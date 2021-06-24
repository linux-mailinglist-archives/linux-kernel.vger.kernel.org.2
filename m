Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC5F3B2FB0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 15:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbhFXNFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 09:05:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhFXNFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 09:05:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8BA78613F3;
        Thu, 24 Jun 2021 13:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624539813;
        bh=29qJHkURQgjJSP98wmIatG7GWQL5T0I2YZMR3NrkmZA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QZpO13JkV8FGpr8VOIcI7px/Tsj6wJG/tuBt96wg1kglgrliKzKkRiPAEnsrEWzHz
         De3kQ3eZeOOus9MyaFporWBp47g4x97oa4B5vBbb8ztwKy2ORG3xKdTpt4lIcmdOmU
         IAz1Oe+DmF1lDAG1m/d2jXqT8ahKAPh5tyzYC7FI=
Date:   Thu, 24 Jun 2021 15:03:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhenguo Zhao <zhenguo6858@gmail.com>
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: n_gsm: add some instructions and code for slaver
Message-ID: <YNSCoj1sRqDTx46X@kroah.com>
References: <1623983464-19846-1-git-send-email-zhenguo6858@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623983464-19846-1-git-send-email-zhenguo6858@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 10:31:04AM +0800, Zhenguo Zhao wrote:
> From: Zhenguo Zhao <Zhenguo.Zhao1@unisoc.com>
> 
> The gsm driver config to master or slaver by initiator,

I do not understand.

Also, we generally do not want to use these terms anymore, please pick a
different term to use.  Please see commit a5f526ecb075 ("CodingStyle:
Inclusive Terminology") in the kernel tree for more information about
this.

thanks,

greg k-h
