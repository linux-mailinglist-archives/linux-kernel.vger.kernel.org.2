Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B71E347DBE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 17:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbhCXQde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 12:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbhCXQdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 12:33:11 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74390C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 09:33:11 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id k10so33961830ejg.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 09:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a5+ZGrrfzNFo/XolIFBAb38yvff/vehqhEWl+2UvE4A=;
        b=bQs8EYCq8gGo6tFEaEsU/dKQ1iHHM8D7KSnfHBZOdmEDD/FYxJWgPAxJkaJkuA6Td/
         v85+940aEsqr3HgBakhc84f6oop7MPjd68Kp+g/vWksiTI1ipOgS1FceVuNw/9h657Nh
         SzgEeXFivRrAgkMi+PCWtE5aJsBPeOyaDREp74RgFNzIyFOt9Fnaaai1UAo5Owmv9TQn
         SaLdn+zdeWsQKgTYZJ/YLZofSCEOoc/uh3PUWSufKI1x5v9EULP1/9s7QerU8I7gDCVG
         byvXmmVvIdTQl9oueCGxfkgrmQLqSa1oZKgw4QuCz7ObuMZi2RUQuglDv/ywMNgkSX8O
         72Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a5+ZGrrfzNFo/XolIFBAb38yvff/vehqhEWl+2UvE4A=;
        b=RT80pCQHzUwj+R50woIZCUbsFy+LjAB6DsYxCh6zdrH1LG4TliAgfLg+LvdLb91+9t
         div/ZsJOeFxUsPt6EW8DMRZB+NwwVXibyG6y8+dWbGR2B/V9TQSBweqiAg94t7RPURh2
         ud/kQBYFebILJpshRDhvdE8XbIO2izkXlc9dz3Jfy+fV8xhYrhs9z8l7syRGY6V+yo9C
         4lbEiOZlc9k7Ov7vJtWp1Bv2ucKZtbItH9yp+xLEyLfMvUIsjmOsHVLqHwYPlTuuigUY
         75AdWuZqWzO21lmaeB8HrdCkHwbGK4LvDMkBrKfq1CcR5RTVWLto39uYkEIhuW3GI+2d
         /R4g==
X-Gm-Message-State: AOAM533Ay3t8Q1iXIGaSa5XrDl8M1TnkZk1IU+BGrGp4JWC9C8ilJNAR
        GL0NJ/m7YVo3qX8EfnHpxINRuTqGxvAi7kapKhBo
X-Google-Smtp-Source: ABdhPJwAd0h1pyDT74BtiwvKnm8XZOlhQQFZw+sVNZKy9MhcHfCCU8ritIoWXmiPg4rJF/kODhjZPTKsAZu+BYh0sdg=
X-Received: by 2002:a17:906:2314:: with SMTP id l20mr4727552eja.178.1616603590004;
 Wed, 24 Mar 2021 09:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <3d15fa1f0c54335f9258d90ea0d11050e780ba70.1616529248.git.rgb@redhat.com>
In-Reply-To: <3d15fa1f0c54335f9258d90ea0d11050e780ba70.1616529248.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 24 Mar 2021 12:32:59 -0400
Message-ID: <CAHC9VhTtkar8zt9JP2o0EX5R5bpHaX45=tNtCLuaDNcwtV8baQ@mail.gmail.com>
Subject: Re: [PATCH v3] audit: log nftables configuration change events once
 per table
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netfilter-devel@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
        twoerner@redhat.com, tgraf@infradead.org, dan.carpenter@oracle.com,
        Jones Desougi <jones.desougi+netfilter@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 4:05 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Reduce logging of nftables events to a level similar to iptables.
> Restore the table field to list the table, adding the generation.
>
> Indicate the op as the most significant operation in the event.
>
> A couple of sample events:
>
> type=PROCTITLE msg=audit(2021-03-18 09:30:49.801:143) : proctitle=/usr/bin/python3 -s /usr/sbin/firewalld --nofork --nopid
> type=SYSCALL msg=audit(2021-03-18 09:30:49.801:143) : arch=x86_64 syscall=sendmsg success=yes exit=172 a0=0x6 a1=0x7ffdcfcbe650 a2=0x0 a3=0x7ffdcfcbd52c items=0 ppid=1 pid=367 auid=unset uid=root gid=root euid=root suid=root fsuid=root egid=roo
> t sgid=root fsgid=root tty=(none) ses=unset comm=firewalld exe=/usr/bin/python3.9 subj=system_u:system_r:firewalld_t:s0 key=(null)
> type=NETFILTER_CFG msg=audit(2021-03-18 09:30:49.801:143) : table=firewalld:2 family=ipv6 entries=1 op=nft_register_table pid=367 subj=system_u:system_r:firewalld_t:s0 comm=firewalld
> type=NETFILTER_CFG msg=audit(2021-03-18 09:30:49.801:143) : table=firewalld:2 family=ipv4 entries=1 op=nft_register_table pid=367 subj=system_u:system_r:firewalld_t:s0 comm=firewalld
> type=NETFILTER_CFG msg=audit(2021-03-18 09:30:49.801:143) : table=firewalld:2 family=inet entries=1 op=nft_register_table pid=367 subj=system_u:system_r:firewalld_t:s0 comm=firewalld
>
> type=PROCTITLE msg=audit(2021-03-18 09:30:49.839:144) : proctitle=/usr/bin/python3 -s /usr/sbin/firewalld --nofork --nopid
> type=SYSCALL msg=audit(2021-03-18 09:30:49.839:144) : arch=x86_64 syscall=sendmsg success=yes exit=22792 a0=0x6 a1=0x7ffdcfcbe650 a2=0x0 a3=0x7ffdcfcbd52c items=0 ppid=1 pid=367 auid=unset uid=root gid=root euid=root suid=root fsuid=root egid=r
> oot sgid=root fsgid=root tty=(none) ses=unset comm=firewalld exe=/usr/bin/python3.9 subj=system_u:system_r:firewalld_t:s0 key=(null)
> type=NETFILTER_CFG msg=audit(2021-03-18 09:30:49.839:144) : table=firewalld:3 family=ipv6 entries=30 op=nft_register_chain pid=367 subj=system_u:system_r:firewalld_t:s0 comm=firewalld
> type=NETFILTER_CFG msg=audit(2021-03-18 09:30:49.839:144) : table=firewalld:3 family=ipv4 entries=30 op=nft_register_chain pid=367 subj=system_u:system_r:firewalld_t:s0 comm=firewalld
> type=NETFILTER_CFG msg=audit(2021-03-18 09:30:49.839:144) : table=firewalld:3 family=inet entries=165 op=nft_register_chain pid=367 subj=system_u:system_r:firewalld_t:s0 comm=firewalld
>
> The issue was originally documented in
> https://github.com/linux-audit/audit-kernel/issues/124
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
> Changelog:
> v3:
> - fix function braces, reduce parameter scope
> - pre-allocate nft_audit_data per table in step 1, bail on ENOMEM
>
> v2:
> - convert NFT ops to array indicies in nft2audit_op[]
> - use linux lists
> - use functions for each of collection and logging of audit data
> ---
>  include/linux/audit.h         |  28 ++++++
>  net/netfilter/nf_tables_api.c | 160 ++++++++++++++++------------------
>  2 files changed, 105 insertions(+), 83 deletions(-)

...

> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 82b7c1116a85..5fafcf4c13de 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -118,6 +118,34 @@ enum audit_nfcfgop {
>         AUDIT_NFT_OP_INVALID,
>  };
>
> +static const u8 nft2audit_op[NFT_MSG_MAX] = { // enum nf_tables_msg_types
> +       [NFT_MSG_NEWTABLE]      = AUDIT_NFT_OP_TABLE_REGISTER,
> +       [NFT_MSG_GETTABLE]      = AUDIT_NFT_OP_INVALID,
> +       [NFT_MSG_DELTABLE]      = AUDIT_NFT_OP_TABLE_UNREGISTER,
> +       [NFT_MSG_NEWCHAIN]      = AUDIT_NFT_OP_CHAIN_REGISTER,
> +       [NFT_MSG_GETCHAIN]      = AUDIT_NFT_OP_INVALID,
> +       [NFT_MSG_DELCHAIN]      = AUDIT_NFT_OP_CHAIN_UNREGISTER,
> +       [NFT_MSG_NEWRULE]       = AUDIT_NFT_OP_RULE_REGISTER,
> +       [NFT_MSG_GETRULE]       = AUDIT_NFT_OP_INVALID,
> +       [NFT_MSG_DELRULE]       = AUDIT_NFT_OP_RULE_UNREGISTER,
> +       [NFT_MSG_NEWSET]        = AUDIT_NFT_OP_SET_REGISTER,
> +       [NFT_MSG_GETSET]        = AUDIT_NFT_OP_INVALID,
> +       [NFT_MSG_DELSET]        = AUDIT_NFT_OP_SET_UNREGISTER,
> +       [NFT_MSG_NEWSETELEM]    = AUDIT_NFT_OP_SETELEM_REGISTER,
> +       [NFT_MSG_GETSETELEM]    = AUDIT_NFT_OP_INVALID,
> +       [NFT_MSG_DELSETELEM]    = AUDIT_NFT_OP_SETELEM_UNREGISTER,
> +       [NFT_MSG_NEWGEN]        = AUDIT_NFT_OP_GEN_REGISTER,
> +       [NFT_MSG_GETGEN]        = AUDIT_NFT_OP_INVALID,
> +       [NFT_MSG_TRACE]         = AUDIT_NFT_OP_INVALID,
> +       [NFT_MSG_NEWOBJ]        = AUDIT_NFT_OP_OBJ_REGISTER,
> +       [NFT_MSG_GETOBJ]        = AUDIT_NFT_OP_INVALID,
> +       [NFT_MSG_DELOBJ]        = AUDIT_NFT_OP_OBJ_UNREGISTER,
> +       [NFT_MSG_GETOBJ_RESET]  = AUDIT_NFT_OP_OBJ_RESET,
> +       [NFT_MSG_NEWFLOWTABLE]  = AUDIT_NFT_OP_FLOWTABLE_REGISTER,
> +       [NFT_MSG_GETFLOWTABLE]  = AUDIT_NFT_OP_INVALID,
> +       [NFT_MSG_DELFLOWTABLE]  = AUDIT_NFT_OP_FLOWTABLE_UNREGISTER,
> +};

The previously reported problem with this as a static still exists,
correct?  It does seem like this should live in nf_tables_api.c
doesn't it?

-- 
paul moore
www.paul-moore.com
