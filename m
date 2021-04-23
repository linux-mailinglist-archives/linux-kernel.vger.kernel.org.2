Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721AB36902F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 12:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241897AbhDWKSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 06:18:00 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:47743 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhDWKRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 06:17:47 -0400
Received: from [192.168.1.18] ([86.243.172.93])
        by mwinf5d51 with ME
        id wAH82400W21Fzsu03AH8EJ; Fri, 23 Apr 2021 12:17:09 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 23 Apr 2021 12:17:09 +0200
X-ME-IP: 86.243.172.93
Subject: Re: [PATCH] nvmem: core: add a missing of_node_put
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        bgolaszewski@baylibre.com, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <2ebc18d9da622afe8681c18349b501a516253041.1618949512.git.christophe.jaillet@wanadoo.fr>
 <93e8b92c-8f4e-9990-ac4d-9688bbaaa6f6@linaro.org>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <b07c059e-bef7-6a8a-31e3-b06a8eef1397@wanadoo.fr>
Date:   Fri, 23 Apr 2021 12:17:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <93e8b92c-8f4e-9990-ac4d-9688bbaaa6f6@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 23/04/2021 à 11:30, Srinivas Kandagatla a écrit :
> 
> 
> On 20/04/2021 21:12, Christophe JAILLET wrote:
>> 'for_each_child_of_node' performs an of_node_get on each iteration, so a
>> return from the middle of the loop requires an of_node_put.
>>
>> Fixes: e888d445ac33 ("nvmem: resolve cells from DT at registration time")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   drivers/nvmem/core.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>> index bca671ff4e54..4375e52ba6c2 100644
>> --- a/drivers/nvmem/core.c
>> +++ b/drivers/nvmem/core.c
>> @@ -686,12 +686,15 @@ static int nvmem_add_cells_from_of(struct 
>> nvmem_device *nvmem)
>>               continue;
>>           if (len < 2 * sizeof(u32)) {
>>               dev_err(dev, "nvmem: invalid reg on %pOF\n", child);
>> +            of_node_put(child);
>>               return -EINVAL;
>>           }
>>           cell = kzalloc(sizeof(*cell), GFP_KERNEL);
>> -        if (!cell)
>> +        if (!cell) {
>> +            of_node_put(child);
>>               return -ENOMEM;
>> +        }
>>           cell->nvmem = nvmem;
>>           cell->np = of_node_get(child);
>> @@ -717,6 +720,7 @@ static int nvmem_add_cells_from_of(struct 
>> nvmem_device *nvmem)
>>               kfree_const(cell->name);
>>               of_node_put(cell->np);
>>               kfree(cell);
>> +            of_node_put(child);
> 
> two of_node_put looks bit confusing to the reader, can you move the
> 
> cell->np = of_node_get(child); just before nvmem_cell_add(cell);
> so that we can remove extra put.
> 

Sure.
I didn't pay attention that cell->np and child were the same and that 
the code looked odd now.

Thx for the review and the comment.


> Was this reported by some kind of static analysis tool?
 >

Yes, this was found by coccinelle.
The script used was an old one posted by Julia Lawall a few years ago:

// <smpl>
@r@
local idexpression n;
expression e1,e2;
iterator name for_each_node_by_name, for_each_node_by_type,
for_each_compatible_node, for_each_matching_node,
for_each_matching_node_and_match, for_each_child_of_node,
for_each_available_child_of_node, for_each_node_with_property;
iterator i;
statement S;
expression list [n1] es;
@@

(
(
for_each_node_by_name(n,e1) S
|
for_each_node_by_type(n,e1) S
|
for_each_compatible_node(n,e1,e2) S
|
for_each_matching_node(n,e1) S
|
for_each_matching_node_and_match(n,e1,e2) S
|
for_each_child_of_node(e1,n) S
|
for_each_available_child_of_node(e1,n) S
|
for_each_node_with_property(n,e1) S
)
&
i(es,n,...) S
)

@@
local idexpression r.n;
iterator r.i;
expression e;
expression list [r.n1] es;
@@

  i(es,n,...) {
    ...
(
    of_node_put(n);
|
    e = n
|
    return n;
|
+  of_node_put(n);
?  return ...;
)
    ...
  }

@@
local idexpression r.n;
iterator r.i;
expression e;
expression list [r.n1] es;
@@

  i(es,n,...) {
    ...
(
    of_node_put(n);
|
    e = n
|
+  of_node_put(n);
?  break;
)
    ...
  }
... when != n

@@
local idexpression r.n;
iterator r.i;
expression e;
identifier l;
expression list [r.n1] es;
@@

  i(es,n,...) {
    ...
(
    of_node_put(n);
|
    e = n
|
+  of_node_put(n);
?  goto l;
)
    ...
  }
...
l: ... when != n
// </smpl>


> 
> --srini
> 
> 
> 
>>               return -EINVAL;
>>           }
>>
> 

