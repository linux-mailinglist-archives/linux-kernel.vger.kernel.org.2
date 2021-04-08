Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5460A357A32
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 04:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhDHCNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 22:13:54 -0400
Received: from mail.kingsoft.com ([114.255.44.145]:20449 "EHLO
        mail.kingsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhDHCNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 22:13:52 -0400
X-AuditID: 0a580157-e3bff7000005ef4a-b7-606e66cf2c03
Received: from mail.kingsoft.com (localhost [10.88.1.79])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mail.kingsoft.com (SMG-1-NODE-87) with SMTP id 3F.7E.61258.FC66E606; Thu,  8 Apr 2021 10:13:35 +0800 (HKT)
Received: from alex-virtual-machine (172.16.253.254) by KSBJMAIL4.kingsoft.cn
 (10.88.1.79) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 8 Apr 2021
 10:13:35 +0800
Date:   Thu, 8 Apr 2021 10:13:35 +0800
From:   Aili Yao <yaoaili@kingsoft.com>
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
CC:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, Andy Lutomirski <luto@kernel.org>,
        "HORIGUCHI NAOYA( =?UTF-8?B?5aCA5Y+j?= =?UTF-8?B?44CA55u05Lmf?=)" 
        <naoya.horiguchi@nec.com>, <yaoaili@kingsoft.com>
Subject: Re: [RFC 0/4] Fix machine check recovery for copy_from_user
Message-ID: <20210408101335.28fd3692@alex-virtual-machine>
In-Reply-To: <20210326000235.370514-1-tony.luck@intel.com>
References: <20210326000235.370514-1-tony.luck@intel.com>
Organization: kingsoft
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.253.254]
X-ClientProxiedBy: KSBJMAIL1.kingsoft.cn (10.88.1.31) To KSBJMAIL4.kingsoft.cn
 (10.88.1.79)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsXCFcHor3s+LS/B4FermcXnDf/YLC7vmsNm
        cW/Nf1aL87vWslpcbDzAaPHmwj0Wix8bHrM6sHt8b+1j8Vi85yWTx6ZVnWwemz5NYvd4cXUj
        i8fnTXIBbFFcNimpOZllqUX6dglcGXuvfmMp+CZQcfUqewPjf54uRk4OCQETiXsNb5i6GLk4
        hASmM0m8vHwFynnJKHGxdQEzSBWLgIpEy/1JYDabgKrErnuzWEFsEQFnifmN7YwgDcwCzxgl
        Jvx+DVYkLOAi8aFpLlsXIwcHr4CVxM1leiAmJ5C54r8niCkkYCkx70MVSDG/gJhE75X/TCBh
        CQF7icfrFUHCvAKCEidnPmEBsZkFdCROrDrGDGHLS2x/OwfMFhJQlDi85Bc7xCtKEke6Z7BB
        2LESTQdusU1gFJ6FZNQsJKNmIRm1gJF5FSNLcW664SZGSDyE72Cc1/RR7xAjEwfjIUYJDmYl
        Ed4dvdkJQrwpiZVVqUX58UWlOanFhxilOViUxHnza3IThATSE0tSs1NTC1KLYLJMHJxSDUxb
        JKqT9pxd2+3j62Eu4WC37UpOuY20g6HdeW7Di53dp3NN2aKjyrbevHpY9cHSrGAmQ1Wje/nM
        r7j31enyN/1MeF/g+lzOMp9L5P3V9wraVo+jbla9MJV/YzBZJfBisu7/Ty1lt+aVBv+aouGh
        2BBjPGVR9SWh+W/aVh6sj7B18WTUnvrJ5X23wpW/5c3if649+rwylOHSLpbTljNfbGIuCGp8
        +p1nds3E8/fST+5h+n9xd7dRULn7Xfu1uj3LOpmSvBi3sjz1j9sn6BrZqXZ6ymKeV2GR9h05
        xlsra+VCJLMafHxfm83QelUutDXLXPGHQdLFDycLNx7e42Fx9pvlFZUFziIfa9s27rlyXYml
        OCPRUIu5qDgRACgUgg72AgAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Mar 2021 17:02:31 -0700
Tony Luck <tony.luck@intel.com> wrote:

> Maybe this is the way forward?  I made some poor choices before
> to treat poison consumption in the kernel when accessing user data
> (get_user() or copy_from_user()) ... in particular assuming that
> the right action was sending a SIGBUS to the task as if it had
> synchronously accessed the poison location.
> 
> First three patches may need to be combined (or broken up differently)
> for bisectablilty. But they are presented separately here since they
> touch separate parts of the problem.
> 
> Second part is definitley incomplete. But I'd like to check that it
> is the right approach before expending more brain cells in the maze
> of nested macros that is lib/iov_iter.c
> 
> Last part has been posted before. It covers the case where the kernel
> takes more than one swing at reading poison data before returning to
> user.
> 
> Tony Luck (4):
>   x86/mce: Fix copyin code to return -EFAULT on machine check.
>   mce/iter: Check for copyin failure & return error up stack
>   mce/copyin: fix to not SIGBUS when copying from user hits poison
>   x86/mce: Avoid infinite loop for copy from user recovery
> 
>  arch/x86/kernel/cpu/mce/core.c     | 63 +++++++++++++++++++++---------
>  arch/x86/kernel/cpu/mce/severity.c |  2 -
>  arch/x86/lib/copy_user_64.S        | 18 +++++----
>  fs/iomap/buffered-io.c             |  8 +++-
>  include/linux/sched.h              |  2 +-
>  include/linux/uio.h                |  2 +-
>  lib/iov_iter.c                     | 15 ++++++-
>  7 files changed, 77 insertions(+), 33 deletions(-)
> 

I have one scenario, may you take into account:

If one copyin case occurs, write() returned by your patch, the user process may
check the return values, for errors, it may exit the process, then the error page
will be freed, and then the page maybe alloced to other process or to kernel itself,
then code will initialize it and this will trigger one SRAO, if it's used by kernel,
we may do nothing for this, and kernel may still touch it, and lead to one panic.

Is this we expect? 

Thanks!
Aili Yao
