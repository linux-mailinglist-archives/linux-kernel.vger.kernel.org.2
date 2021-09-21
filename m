Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12124413326
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 14:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbhIUMIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 08:08:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:59992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232515AbhIUMIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 08:08:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5D8F360F43;
        Tue, 21 Sep 2021 12:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632226001;
        bh=splY08tv2Ba0Wf51sxfKsm7eB0Z4ABs5Pw2cCaiPjyU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZIsj8k/soU9Lm2COKGpAsVPg2TvRtfZpb2K/iXz+8hHHFVFtsKB4GeLGn49Hy/6T/
         7yTVj7vU1A9dDV88zrjNACX897aMmTZQ6XdpDd8bpvnjfBSiUhnSOfI73u2wG6ntGo
         FLxmbI5l55CcCwJhHGmKLdp1/e+xxi5GPNtJ9HIqA0oHzXgWPM8o+dABiKV/obLzq8
         KYMSQFRETu5tgrj/hmGGHq67LitvAVa+VwP9OwnfH+y3cS7gONvPpYvq8WOZTaxCun
         S6T6Sh/rAdfIqLrdMkXcGV66DOJhZRD9mBLnPApq925XtZUbWScoTozYUUGOA6WD7X
         WWXzi/Im5qpiw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mSeXn-0004lp-1v; Tue, 21 Sep 2021 14:06:39 +0200
Date:   Tue, 21 Sep 2021 14:06:39 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Himadri Pandya <himadrispandya@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] USB: serial: f81232: use usb_control_msg_recv()
 and usb_control_msg_send()
Message-ID: <YUnKzz1Cwsc9hT++@hovoldconsulting.com>
References: <20210801203122.3515-1-himadrispandya@gmail.com>
 <20210801203122.3515-4-himadrispandya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210801203122.3515-4-himadrispandya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 02:01:19AM +0530, Himadri Pandya wrote:
> New wrapper functions usb_control_msg_send/recv accept stack variables
> for usb message buffer and eliminate the need of creating temporary dma
> buffers. The wrappers also have proper error checks for short
> read/writes. Hence use the wrappers instead of using usb_control_msg()
> directly.
> 
> Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>

I amended the commit message as follows when applying this one:

 USB: serial: f81232: use usb_control_msg_recv() and usb_control_msg_send()
    
    The new wrapper functions usb_control_msg_send/recv accept stack
    variables for USB message buffers and eliminate the need of manually
    allocating temporary DMA buffers. The read wrapper also treats short
    reads as errors. Hence use the wrappers instead of using
    usb_control_msg() directly.
    
    Note that the conversion of f81534a_ctrl_set_register() adds an extra an
    extra allocation and memcpy for every retry. Since this function is
    called rarely and retries are hopefully rare, the overhead should be
    acceptable.
    
    Also note that short reads are now logged as -EREMOTEIO instead of
    indicating the amount of data read.

Johan
