Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069893F861A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 13:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241963AbhHZLIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 07:08:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241924AbhHZLIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 07:08:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D06B561053;
        Thu, 26 Aug 2021 11:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629976083;
        bh=d2qWDVtkg+46Zy5roR3shzf2BhW2pwm9IVc0KCDv3B0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UzbqzUCv4pRt4N7yauho0F62cxUMbBQ4eySW83ImQM8mDbLPrX9CJNjRCByYxZOaN
         DRLamNsYNNihHp5CRYny9LQiVys+ALnD7gyUrgPRqYnbPK6Ewlfu2hQmPO2WBVsbYy
         wk3Ss0ROOmCoaFRhBqDTMEzKheaJSs6PbR7846Eex23M3yx5RWvlWn8lFnXQETp1c6
         f5JqKMPC2+bINcM1p3Y1q19SJb0pj1df2t/EbhS/nQ+3gdxNl2NXAfLEwXZcNNaJ0F
         hF/riS5/iQHuc8zXtD/nY+z1LzPcqxLdNj5YjA4LFKZey1ZCEM4cd6kcvFPfuqtoWv
         o+CKmd0ojuF2A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mJDEl-0007k9-Bf; Thu, 26 Aug 2021 13:08:00 +0200
Date:   Thu, 26 Aug 2021 13:07:59 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: pl2303: fix GL type detection
Message-ID: <YSd2D92RL9pJMdQY@hovoldconsulting.com>
References: <20210826110239.5269-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826110239.5269-1-robert.marko@sartura.hr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 01:02:39PM +0200, Robert Marko wrote:
> At least some PL2303GL have a bcdDevice of 0x405 instead of 0x100 as the
> datasheet claims. Add it to the list of known release numbers for the
> HXN (G) type.
> 
> Fixes: 894758d0571d ("USB: serial: pl2303: tighten type HXN (G) detection")
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Thanks for the patch, looks good.

Could you post the output of lsusb -v for your device as well for
completeness?

Johan
