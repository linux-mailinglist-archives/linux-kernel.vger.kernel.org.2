Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D463432B5
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 14:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhCUNSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 09:18:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229874AbhCUNR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 09:17:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53E3861946;
        Sun, 21 Mar 2021 13:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616332677;
        bh=isCNujXibSaFJiqhoQRS4sDu8B3NRAp4PtFY+VXoJIg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r2tk7tozzqoRHbsrRNnbVgKzwX0z3uuY51zL3aF0Q+hlM4LuMLDmzOXEkEcfEDxUj
         PNvt11cHe6nuPlnapmaW5OPqH57JdTnKlFUUkQhK8VM4yjDJwYWV8PCm0bH+vy+k1F
         r+5K03kPlFY5mRkirHQPm0XrWQXLqnvY1xjtL9AVjSIuyXpFLTVny6zndPiN0tQ4FD
         kGX5Ydc7ZP9WdvZ1nxh8O2hiJTPR9rnoxsceZeC+Ng7i9HTCTsUWHnEd5ApoDV9Y4G
         MBgaRKgE3IRSVJ2QOll44JmcUpdCUeDqV+g5otBQq8T0ZmSzInDurkfapgqNXjuemZ
         5b7qaZZ5hEI1g==
Date:   Sun, 21 Mar 2021 22:17:53 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     LinuxKernel <linux-kernel@vger.kernel.org>
Subject: Re: Bootconfig ..too many deep level of header file
Message-Id: <20210321221753.5cc974f0d4cb8a1ed65c675f@kernel.org>
In-Reply-To: <20210321030855.GA18105@debian>
References: <20210321030855.GA18105@debian>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhaskar,

On Sun, 21 Mar 2021 08:38:56 +0530
Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:

>  Hey, Masami
> 
>  I was wondering why so many level of "deep nesting" of a particualr header
>  file like this one :
> 
>  ✔ ~/git-linux/linux/tools/bootconfig/include/linux [patch L|✔]
> 08:34 $ cat bootconfig.h
> /* SPDX-License-Identifier: GPL-2.0 */
> #ifndef _BOOTCONFIG_LINUX_BOOTCONFIG_H
> #define _BOOTCONFIG_LINUX_BOOTCONFIG_H
> 
> #include "../../../../include/linux/bootconfig.h"
> 
> #endif
> 
> I am surely missing some basic stuff...but...anyway, I have taken a peek on other files in the same dir and none have the nesting like that(the include ../ ...line)
> 
> Any specific reason? OR did you thought of keeping all the header file in one paplace(wildly guessing) ...

If you carefully check the number of ../, you can find that it refers the
 <topdir>/include/linux/bootconfig.h.
Since the bootconfig library code needs bootconfig.h but I don't like to make
a copy of the bootconfig.h under the tools directory, I made a dummy header
file which links to the kernel's bootconfig.h.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
