Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E708D4388D7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 14:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbhJXMch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 08:32:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229867AbhJXMce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 08:32:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9356760F45;
        Sun, 24 Oct 2021 12:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635078614;
        bh=7Kw7ugt5vi+qCoUVxm3waBXRUBJBDBwINu9hoZF3yRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BzR1sbaUs8dWo8NiXdQe9Fh/o2Cbd0sK9K5Dm4MfX94h5xsl6dvfMnAeaz2IAdpnK
         nMg94BL1XX5wzHFfqJqVn3GTOmZTnVOsfjvetcM0KriuD3uzfUoLk7DcOHz02KNiFY
         LkWe9vkVMkl4o6P+xRzU1anDloCRA/3/XYb75GrY=
Date:   Sun, 24 Oct 2021 14:30:11 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Remove four unused semaphores
Message-ID: <YXVR06W46mx0EaZU@kroah.com>
References: <20211022113936.7909-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022113936.7909-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 01:39:36PM +0200, Fabio M. De Francesco wrote:
> Remove four initialized but unused semaphores.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

What semaphores were removed?  Please be specific.

And can this be broken up into "one removal per patch?"

thanks,

greg k-h
