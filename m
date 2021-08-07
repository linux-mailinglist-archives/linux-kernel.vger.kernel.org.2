Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F24C3E3740
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 23:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhHGVyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 17:54:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44347 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229537AbhHGVyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 17:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628373267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Ouhso+fXGviI6knKE4P53n2vIYIknqTkdYBIyB7lgc=;
        b=Mf6If6r4T61+ZQPIIMdFNTDMpMYH8y+NZB+fIyBPDGzTQldoTXJUcq4bGt+o1XHZZ4R+sy
        hvigszGhNX6sZ6GPbfAJhtBnrPzgQFTQsR1CLC62rL86+zIcTTK0dY1sLVl5k+WukbLnTq
        w7TpNaJcEJp++2iDNUZlLVqXcZi0IMk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-CD_f0CFdMCW7-ZJF2v296Q-1; Sat, 07 Aug 2021 17:54:26 -0400
X-MC-Unique: CD_f0CFdMCW7-ZJF2v296Q-1
Received: by mail-qv1-f72.google.com with SMTP id kk20-20020a0562145094b029034e3ec4ffb4so3256625qvb.11
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 14:54:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4Ouhso+fXGviI6knKE4P53n2vIYIknqTkdYBIyB7lgc=;
        b=eU42GEUYvUHO08zN7njwvZAD/XQE1gNqODnhTt7CZYmOcesJzn8RTYMDEccMz4qE3e
         TmnAhwwDx8MLO386qGK1CQDv5c8V7PiPqXtwG9A5UKAdDMgbocODgTlzCu561wI4kaUA
         LCDFBuGh4AGigTEw4kJw0Fob5YptzdC3gjqDzXod1AX/SvGPLBxT6QbfAs83+6gENA+H
         45T3P1r1kQhQRbdLuHZkzA0RLlXdi0SQiJGLSBDFYNMX0uaz5qIjBaXFiDKiHon9NmW3
         7ibd6LcSpV/TwNTG/XTiNf9hn+sQFX3dbfks1U+qGbBK6XZbptOixuAlFKurEf9OpPZx
         9NRg==
X-Gm-Message-State: AOAM530tYnWyXscEfVEMo7ZcwI9qvmRa09ZUpmr56F1UL6y3Yzf0tc8F
        V8FY/k8JxijdBWV4JefZk1MHzV5T915qe31N03v8F9/aRyPCypre9KhBSpss5D6EeSV/ZdFds+3
        N9BuBTkxy8aWYDY78ySdzCQKT3QEEv0qBpynzKxgLSs5o5x/R6uI46PVVzXXJwm6ssCy/GiuIbh
        sM
X-Received: by 2002:ac8:4d8e:: with SMTP id a14mr14314799qtw.157.1628373265829;
        Sat, 07 Aug 2021 14:54:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2rRCA7TcY3owPv2AMPYK3GeSQp2u20MynsAjO59yMMmC70AXO/qIrutyCyYqEBN9RYM0xxg==
X-Received: by 2002:ac8:4d8e:: with SMTP id a14mr14314780qtw.157.1628373265536;
        Sat, 07 Aug 2021 14:54:25 -0700 (PDT)
Received: from jtoppins.rdu.csb ([107.15.110.69])
        by smtp.gmail.com with ESMTPSA id j185sm6781368qkf.28.2021.08.07.14.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Aug 2021 14:54:25 -0700 (PDT)
Subject: Re: [PATCH net-next 2/2] bonding: combine netlink and console error
 messages
To:     Joe Perches <joe@perches.com>, netdev@vger.kernel.org
Cc:     Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
References: <cover.1628306392.git.jtoppins@redhat.com>
 <a36c7639a13963883f49c272ed7993c9625a712a.1628306392.git.jtoppins@redhat.com>
 <37c7bbbb01ede99974fc9ce3c3f5dad4845df9ee.camel@perches.com>
From:   Jonathan Toppins <jtoppins@redhat.com>
Message-ID: <f519f9eb-aefd-4d0a-01ce-4ed37b7930ef@redhat.com>
Date:   Sat, 7 Aug 2021 17:54:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <37c7bbbb01ede99974fc9ce3c3f5dad4845df9ee.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/21 11:52 PM, Joe Perches wrote:
> On Fri, 2021-08-06 at 23:30 -0400, Jonathan Toppins wrote:
>> There seems to be no reason to have different error messages between
>> netlink and printk. It also cleans up the function slightly.
> []
>> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> []
>> +#define BOND_NL_ERR(bond_dev, extack, errmsg) do {		\
>> +	NL_SET_ERR_MSG(extack, errmsg);				\
>> +	netdev_err(bond_dev, "Error: " errmsg "\n");		\
>> +} while (0)
>> +
>> +#define SLAVE_NL_ERR(bond_dev, slave_dev, extack, errmsg) do {	\
>> +	NL_SET_ERR_MSG(extack, errmsg);				\
>> +	slave_err(bond_dev, slave_dev, "Error: " errmsg "\n");	\
>> +} while (0)
> 
> If you are doing this, it's probably smaller object code to use
> 	"%s", errmsg
> as the errmsg string can be reused
> 
> #define BOND_NL_ERR(bond_dev, extack, errmsg)			\
> do {								\
> 	NL_SET_ERR_MSG(extack, errmsg);				\
> 	netdev_err(bond_dev, "Error: %s\n", errmsg);		\
> } while (0)
> 
> #define SLAVE_NL_ERR(bond_dev, slave_dev, extack, errmsg)	\
> do {								\
> 	NL_SET_ERR_MSG(extack, errmsg);				\
> 	slave_err(bond_dev, slave_dev, "Error: %s\n", errmsg);	\
> } while (0)
> 
> 

I like the thought and would agree if not for how NL_SET_ERR_MSG is 
coded. Unfortunately it does not appear as though doing the above change 
actually generates smaller object code. Maybe I have incorrectly 
interpreted something?

$ git show
commit 6bb346263b4e9d008744b45af5105df309c35c1a (HEAD -> 
upstream-bonding-cleanup)
Author: Jonathan Toppins <jtoppins@redhat.com>
Date:   Sat Aug 7 17:34:58 2021 -0400

     object code optimization

diff --git a/drivers/net/bonding/bond_main.c 
b/drivers/net/bonding/bond_main.c
index 46b95175690b..e2903ae7cdab 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1714,12 +1714,12 @@ void bond_lower_state_changed(struct slave *slave)

  #define BOND_NL_ERR(bond_dev, extack, errmsg) do {             \
         NL_SET_ERR_MSG(extack, errmsg);                         \
-       netdev_err(bond_dev, "Error: " errmsg "\n");            \
+       netdev_err(bond_dev, "Error: %s\n", errmsg);            \
  } while (0)

  #define SLAVE_NL_ERR(bond_dev, slave_dev, extack, errmsg) do { \
         NL_SET_ERR_MSG(extack, errmsg);                         \
-       slave_err(bond_dev, slave_dev, "Error: " errmsg "\n");  \
+       slave_err(bond_dev, slave_dev, "Error: %s\n", errmsg);  \
  } while (0)

  /* enslave device <slave> to bond device <master> */
$ git log --oneline -3
6bb346263b4e (HEAD -> upstream-bonding-cleanup) object code optimization
a36c7639a139 bonding: combine netlink and console error messages
88916c847e85 bonding: remove extraneous definitions from bonding.h
jtoppins@jtoppins:~/projects/linux-rhel7$ git rebase -i --exec "make 
drivers/net/bonding/bond_main.o; ls -l drivers/net/bonding/bond_main.o" 
HEAD^^
hint: Waiting for your editor to close the file... Error detected while 
processing 
/home/jtoppins/.vim/bundle/cscope_macros.vim/plugin/cscope_macros.vim:
line   42:
E568: duplicate cscope database not added
Press ENTER or type command to continue
Executing: make menuconfig


*** End of the configuration.
*** Execute 'make' to start the build or try 'make help'.

Executing: make drivers/net/bonding/bond_main.o; ls -l 
drivers/net/bonding/bond_main.o
   CALL    scripts/checksyscalls.sh
   CALL    scripts/atomic/check-atomics.sh
   DESCEND objtool
   DESCEND bpf/resolve_btfids
   CC [M]  drivers/net/bonding/bond_main.o
-rw-r--r--. 1 jtoppins jtoppins 1777896 Aug  7 17:37 
drivers/net/bonding/bond_main.o
Executing: make drivers/net/bonding/bond_main.o; ls -l 
drivers/net/bonding/bond_main.o
   CALL    scripts/checksyscalls.sh
   CALL    scripts/atomic/check-atomics.sh
   DESCEND objtool
   DESCEND bpf/resolve_btfids
   CC [M]  drivers/net/bonding/bond_main.o
-rw-r--r--. 1 jtoppins jtoppins 1778320 Aug  7 17:37 
drivers/net/bonding/bond_main.o
Successfully rebased and updated refs/heads/upstream-bonding-cleanup.

It appears the change increases bond_main.o by 424 (1778320-1777896) bytes.

