Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F3A37FD11
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 20:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhEMSFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 14:05:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:47676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231447AbhEMSE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 14:04:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E607861438;
        Thu, 13 May 2021 18:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620929026;
        bh=pSnURB3mZsZn1Mf+5FCKkw2EgtO0kvoOufHFukSVgeA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CQb/gSEV8rBchGyBDkiJFiihVW8mDad2MYTf3FbNXINgiPDGAOJfnjVaPunmHX4Wf
         KuAcb9KTl0UDfP15s8713ClRT935vQX6smv1wQa2MTdmWrshJuLfsQ71SYRbRoUsfF
         TwUE/2KSBZrRh8jvj37+Jh04ZeFChYQEQptb6JSU=
Date:   Thu, 13 May 2021 20:03:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] Remove set but unused variables
Message-ID: <YJ1p//NsZRdYRiO9@kroah.com>
References: <20210512132344.30225-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512132344.30225-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 03:23:42PM +0200, Fabio M. De Francesco wrote:
> Removed set but unused variables from HalPhyRf_8723B.c. Patch 1/2 removes
> variables detected by GCC while compiling for x86_64. Patch 2/2 removes
> variables detected by the kernel test robot while building for PowerPC.
> 
> Fabio M. De Francesco (2):
>   staging: rtl8723bs: hal: Remove two set but unused variables
>   staging: rtl8723bs: hal: Remove set but unused variables

Those subject lines do NOT match up with the patches you sent out, so
something went wrong.

Can you fix this up and resend this?

thanks,

greg k-h
