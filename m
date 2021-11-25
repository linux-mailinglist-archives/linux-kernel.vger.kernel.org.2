Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 812A645DEB2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 17:43:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241719AbhKYQqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 11:46:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:41722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237194AbhKYQoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 11:44:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8178C6108F;
        Thu, 25 Nov 2021 16:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637858495;
        bh=8DqLv+OqtZUk1jp02ETyR1S9lJpF0HOuZitAup5P6no=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QO305DD0iwziWMwFBnxVsAmK63WvSGTCReEa0eTQj9HQPd7pRjDOD43KHhxveybBH
         BCBuWLjzOai/DLoZyFSJuXPNN/psFzgz2xheRdog0muLhgWK+A2QAfcQv5tgViYrvQ
         xQJMn0CV1EBENWyuQ8Gizj+NQZAqZGLewgJtkkGU=
Date:   Thu, 25 Nov 2021 17:41:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zameer Manji <zmanji@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: remove unused hal fields
Message-ID: <YZ+8o591fl5uQ5dC@kroah.com>
References: <20211117142108.1505715-1-zmanji@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117142108.1505715-1-zmanji@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 02:20:20PM +0000, Zameer Manji wrote:
> Several HAL related fields are never used or are useless. This removes
> those fields and any code that is now safe to remove from the field
> deletion.
> 
> The fields that are referenced but are useless are:
> * interfaceIndex: only written to, never read.
> * CurrentCckTxPwrIdx: only written to, never read.
> * CurrentOfdm24GTxPwrIdx: only written to, never read.
> * CurrentBW2024GTxPwrIdx: only written to, never read.
> * CurrentBW4024GTxPwrIdx: only written to, never read.
> * bRDGEnable: never initialized, always false.

Please split this up into one-patch-per-thing, this is very hard to read
and verify that this is all correct when it is lumped together.

Make it a patch series and resend please.

thanks,

greg k-h
