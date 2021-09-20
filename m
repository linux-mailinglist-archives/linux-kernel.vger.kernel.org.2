Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71F1A4113CE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 13:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237282AbhITLxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 07:53:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:58890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230037AbhITLxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 07:53:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8834D60F56;
        Mon, 20 Sep 2021 11:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632138700;
        bh=R4hpSy3PWhjr9L4bh+A4aDF3+YcUOiMbAz5n+KqUC4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AuW1Nd5/EQW2C08y7/APbuAnqo10GUDOKZ1q7eK4Ro6Cg9TCnekQH8EFxYuTU6zLK
         Y0WyTygxeIgrsWvR8a7UlWs/ZAVoX5T6ujsh6+JP8Ufj+7pwKgUevW/15rU8zkpG6T
         k5VKyYqVF3jWeVEtyzaoYrx87BnRWuDazPWGNVVI=
Date:   Mon, 20 Sep 2021 13:51:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH v8 15/19] staging: r8188eu: change the type of a variable
 in rtw_read16()
Message-ID: <YUh1yRL17dVcE6gx@kroah.com>
References: <20210919235356.4151-1-fmdefrancesco@gmail.com>
 <20210919235356.4151-16-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210919235356.4151-16-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 01:53:52AM +0200, Fabio M. De Francesco wrote:
> Change the type of "data" from __le32 to __le16.

Again, why?

