Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED54E35C31B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242788AbhDLJ5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:57:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241993AbhDLJxQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:53:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 404DA6127C;
        Mon, 12 Apr 2021 09:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618221178;
        bh=oPD7yiF73N2zzH0OI5Vm4b3OBjM1RRjm4rXNWn9/nRA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PZghx8JqPkCgTikunNW6mheT/gfJMH7PXHUsfGf6+uNQMGiOQ+DalMQaI3updYN9B
         kjlmwReqikbBEm3Qc2KO+48IhSIndi56T4jW8x6lkHdW5GI8UgeCBT8maM3m0RNxK6
         ugFfUCqdDd72Wv1c02d8mYt9AK4/s2dQr0LfozgY=
Date:   Mon, 12 Apr 2021 11:52:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] USB: serial: closing-wait fixes and cleanups
Message-ID: <YHQYeAJvkwe9+dbQ@kroah.com>
References: <20210412093815.736-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412093815.736-1-johan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 11:38:11AM +0200, Johan Hovold wrote:
> The port drain_delay parameter is used to add a time-based delay when
> closing the port in order to allow the transmit FIFO to drain in cases
> where we don't know how to tell if the FIFO is empty.
> 
> This series removes a redundant time-based delay which is no longer
> needed, and documents the reason for two other uses where such a delay
> is needed to let the transmitter shift register clear. As it turns out,
> this is really only needed for one of the two device types handled by
> the ti_usb_3410_5052 driver.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
