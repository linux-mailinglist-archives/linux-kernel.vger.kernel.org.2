Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD05B3EFEB6
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 10:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239331AbhHRIJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 04:09:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238650AbhHRIJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 04:09:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B283260EB5;
        Wed, 18 Aug 2021 08:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629274108;
        bh=GG5JpS9sjJ2x/CR/nmVlPsHOaCqMoAVyfPe45U4ObGI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WwFbeNnRxqvEi5LganTj1PJ6d0N3e47TDJlV+9S+ht59BPvTGlVTBPsJKm19oB33w
         uThTPEO3Eg8xfN8nsK6oSPMzVzNr5S2Qq2KP/zJYWbC9M5yZhjPxV/+m9m7WCWdZap
         reD96LWh671lm7Ejtqvw5YCWyrX9UqEJjnHfg0QM=
Date:   Wed, 18 Aug 2021 10:08:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ronak Jain <ronak.jain@xilinx.com>
Cc:     michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
        rajan.vaja@xilinx.com, corbet@lwn.net,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        lakshmi.sai.krishna.potthuri@xilinx.com
Subject: Re: [PATCH 0/3] Add support for runtime features
Message-ID: <YRy/+epfpiRq2fLr@kroah.com>
References: <20210817130553.20219-1-ronak.jain@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210817130553.20219-1-ronak.jain@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 06:05:50AM -0700, Ronak Jain wrote:
> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

This footer means that this has to be ignored and can not be used for
kernel development at all.
