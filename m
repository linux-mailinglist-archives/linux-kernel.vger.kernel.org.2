Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C94F319C98
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 11:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbhBLKXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 05:23:31 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:45121 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhBLKVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 05:21:49 -0500
Received: from [192.168.1.155] ([77.9.136.38]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MkYkC-1lbdA13knm-00m1P6; Fri, 12 Feb 2021 11:19:11 +0100
Subject: Re: [PATCH] of: base: improve error message in
 of_phandle_iterator_next()
To:     Rob Herring <robh+dt@kernel.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
References: <20210208165806.25466-1-info@metux.net>
 <CAL_Jsq+aWxmA_tXnhi5PfMieZ0KyKj45kr=OUa8h4mEmn7yLTA@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
Message-ID: <18570ba4-0157-d20d-5371-c0f223d33d4d@metux.net>
Date:   Fri, 12 Feb 2021 11:19:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+aWxmA_tXnhi5PfMieZ0KyKj45kr=OUa8h4mEmn7yLTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ulVbFijtQ8jtKYRG7xNboSa3F1svIdl7MYCglduNiR9lTDHNM53
 zd7Z8T6BTNq3KvkuFQh7BCHXFqgOu22dXRjNNXot4ohGkj6SBe82ZDjWXOo028+rjGnYKf7
 uoez3LzNKRTZe3/a2dRO13HiLq8ShwNP9qD8RnPL9lx2AVO57Hp68riFdGvpvqyFJBbwlNf
 Y7En0e4wQfcJHUmCK7R0Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LWcMNQciUJY=:CwCZlD2K1GPQ1uVCJbyHXM
 j1jphyqxuL4JoAOGLEmVMZm3RQ2NnHSBK29m/kIzwOgnSg+NTc/TuXh/b6rXIIMrZPdx1FTFE
 bBnFLq+bIL0LXZjLMEX+ZFyh4eLDLYXq48bwX7/asU/ESWF2X0P0jI84F2NLSfzJFdk0/hlsr
 6WnH/IfPfYsYw4UEzEE6XyebOOmnWQ3KflviOaIZo+mETTq14Z/HupwkDoeiGqtaDAcbPom1w
 DBPHeq3Bpo0RDsfzm1mP9qh4NWEebIqqGcDXCNfJ+XTulVSsv0u+ZjQuHTIFhddwYV1wFvcaV
 wi+h8KqkutG7goeTaUGpc7wjbzFqUZs/3NQco3GoUXzfEbDSBGEWv1MjGjIpnru8r9OAlc02p
 3SLAG5jWNnoqAEO5yQxrdTfFyQhpO+6R/ODZPSEgVcYJyvvANwCkZ3+ciYY+a
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.02.21 21:13, Rob Herring wrote:
> On Mon, Feb 8, 2021 at 10:58 AM Enrico Weigelt, metux IT consult
> <info@metux.net> wrote:
>>
>> Also print out the phandle ID on error message, as a debug aid.
> 
> I already have this patch applied in my tree. Why do you keep sending it?

Sorry, didn't know that when sending it the 2nd time, missed your last
mail in the mail flood :o

Seems my mail sorting rules are still quite imperfect. I suspect I'm not
the only one with those problems - how do you folks handle that ?


--mtx

-- 
-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
