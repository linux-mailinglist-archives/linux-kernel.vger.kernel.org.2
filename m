Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2293D4363A4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 15:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhJUOB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 10:01:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231154AbhJUOBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 10:01:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A9E660F46;
        Thu, 21 Oct 2021 13:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634824779;
        bh=HzLChQX0mvFxckfW3SmkemHLISLNU0wbsAjtJa09bR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q0zVW5QG5lbdJTSV+so35cSfO0OLqfkvKrNHq07hY/wXMeet0EQeFCC2zx5G//8La
         qoCzYZCErGtwXY73+atia/39WOWcoVoRM5tsqPEmXJyVuU01QRgdo8KiXceO6S5IG4
         odxg22hFYkRC2Yp9c9Ckh+evsrJrA/v1/mn5kaIE=
Date:   Thu, 21 Oct 2021 15:59:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Abhyuday Godhasara <abhyuday.godhasara@xilinx.com>
Cc:     michal.simek@xilinx.com, rajan.vaja@xilinx.com,
        manish.narani@xilinx.com, zou_wei@huawei.com,
        lakshmi.sai.krishna.potthuri@xilinx.com, wendy.liang@xilinx.com,
        jliang@xilinx.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 0/6] Add Xilinx Event Management Driver
Message-ID: <YXFySMX9f5sLTSto@kroah.com>
References: <20210915131615.16506-1-abhyuday.godhasara@xilinx.com>
 <20211021134644.14407-1-abhyuday.godhasara@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021134644.14407-1-abhyuday.godhasara@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 06:46:38AM -0700, Abhyuday Godhasara wrote:
> This Linux driver provides support to subscribe error/event notification
> and receive notification from firmware for error/event and forward event
> notification to subscribed driver via registered callback.
> 
> All types of events like power and error will be handled from single place
> as part of event management driver.


Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
