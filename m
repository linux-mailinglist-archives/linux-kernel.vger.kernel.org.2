Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7A83F3F47
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 14:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhHVMhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 08:37:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230495AbhHVMhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 08:37:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 09FE961284;
        Sun, 22 Aug 2021 12:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629635820;
        bh=Mz0bHlzVa2KkO/FOv/LW9emHShWh4HwVMwyBlz89Me8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m+hdmC1yKMd2dS7oEaUXuf2rVRvIVsNPThPaovAZaQq+idPJNIVvI7PfOqlNKNlvZ
         1z0vCjZBRQz0ISHVn3nmXzD6chItdV3iVrRX5aRrGMCF0szXEf/HczodEKcrhbEx8+
         eBg/8aB4I0BBPr4Hb64KjDILzeNz1CBtpoh5XXsg=
Date:   Sun, 22 Aug 2021 14:36:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Subject: Re: TODO list for staging/r8188eu
Message-ID: <YSJE6aoH96kh777R@kroah.com>
References: <1897566.d8lQ4HMSh1@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1897566.d8lQ4HMSh1@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2021 at 09:41:20AM +0200, Fabio M. De Francesco wrote:
> Dear Larry, Philip,
> 
> >From what I understand how the development process works, drivers in staging 
> should have a to-do list in the TODO file. Please read https://www.kernel.org/
> doc/html/latest/process/2.Process.html?highlight=todo#staging-trees.
> 
> Could you (as the maintainers of the r8188eu driver) please compile and 
> provide the above mentioned list?

Why don't you provide an initial list for people to work off of if you
feel it is needed here?

thanks,

greg k-h
