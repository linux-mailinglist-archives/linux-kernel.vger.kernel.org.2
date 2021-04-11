Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD0835B20D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 08:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbhDKGn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 02:43:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229452AbhDKGnY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 02:43:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C557610C7;
        Sun, 11 Apr 2021 06:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618123388;
        bh=YFGn2WAKfQ2q4+2h94r4/rjRw6/i8/opvnIP0fHdiVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MUq9Co6uKbz0F2nvF6VIrb3h4g/GvM7Yn6fHZPU+bKLR5QZ1u5wkG24ske1D14Qo0
         oooRhYSGXfiq6ZJVduFlBXx0ds0KetAypM5WO4pNgdTbsq8za+c0m22zdfc65pEd9F
         3x8lUOx3JBfgKDXiRKcA0c5w02nXpyjIBlOVnxsM=
Date:   Sun, 11 Apr 2021 08:43:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3] staging: rtl8723bs: remove unnecessary goto jumps
Message-ID: <YHKaeaEPzoDRKI01@kroah.com>
References: <20210410152536.426047-1-hello@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210410152536.426047-1-hello@bryanbrattlof.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 03:27:02PM +0000, Bryan Brattlof wrote:
> The next instruction for both 'goto exit' jump statements is to
> execute the exit jump instructions regardless. We can safely
> remove all jump statements from __init rtw_drv_entry()
> 
> This will also remove the extra line-break before module_init()
> that checkpatch.pl was concerned with.

When you say "also", that almost always means it should be a separate
patch.  Please do so here, try to do only "one logical thing" per kernel
patch please.

thanks,

greg k-h
