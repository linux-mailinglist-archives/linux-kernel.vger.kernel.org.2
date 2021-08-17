Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF7C3EF124
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 19:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbhHQRyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 13:54:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232376AbhHQRyr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 13:54:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9BDF660FD7;
        Tue, 17 Aug 2021 17:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629222854;
        bh=42LLOIAb6dn09xPxpgC32Toh1HzhIaYvVqgbDlhFlvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IOyZRcYNCNlPpvfRWT4ADs1hcx5kJHKbUcrSt+s8NgtQBRXeAVQDXh6JLVbaIDc2B
         eBzemFucKmuSGe0hbZQdaaqlCTRkuEG/Lmd9ZhH8Q0Iz1RXgPYX8r2TRGq4myvr5qk
         j++ocZsLJWNza6R9M77DfN4PcVq9EA7wItC+vpKk=
Date:   Tue, 17 Aug 2021 19:54:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Aakash Hemadri <aakashhemadri123@gmail.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        linux-staging@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] staging: rtl8732bs: Fix sparse warnings
Message-ID: <YRv3w4y3r84mBjrU@kroah.com>
References: <cover.1629134725.git.aakashhemadri123@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1629134725.git.aakashhemadri123@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 11:00:41PM +0530, Aakash Hemadri wrote:
> This patchset fixes the below sparse warnings
> 
> rtw_security.c:72:50: warning: incorrect type in assignment (different base types)
> rtw_security.c:72:50:    expected restricted __le32 [usertype]
> rtw_security.c:72:50:    got unsigned int
> rtw_security.c:80:50: warning: incorrect type in assignment (different base types)
> rtw_security.c:80:50:    expected restricted __le32 [usertype]
> rtw_security.c:80:50:    got unsigned int
> rtw_security.c:124:33: warning: cast to restricted __le32
> rtw_security.c:509:58: warning: incorrect type in assignment (different base types)
> rtw_security.c:509:58:    expected restricted __le32 [usertype]
> rtw_security.c:509:58:    got unsigned int
> rtw_security.c:517:58: warning: incorrect type in assignment (different base types)
> rtw_security.c:517:58:    expected restricted __le32 [usertype]
> rtw_security.c:517:58:    got unsigned int
> rtw_security.c:621:41: warning: cast to restricted __le32
> 
> This can be applied cleanly on next-20210816, and is compile tested.
> 
> Aakash Hemadri (2):
>   staging: rtl8732bs: incorrect type in assignment
>   staging: rtl8723bs: cast to restricted __le32
> 
>  rtw_security.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)

This series does not apply to my tree at all.  Please fix up and rebase
and resubmit, after reading the mailing list archives for others that
have attempted do do this type of work in the past for this issue.

It is not a trivial change that is needed...

thanks,

greg k-h
