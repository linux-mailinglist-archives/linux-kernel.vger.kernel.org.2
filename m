Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DC33E133F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 12:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240566AbhHEKuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 06:50:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232761AbhHEKuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 06:50:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3922D61078;
        Thu,  5 Aug 2021 10:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628160599;
        bh=SthkhSquS85GXKy9NWYR3UdjN9V1PIPsmvC9ZDihriw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=su0za5GN/yilG07ZhxIw4AeQrE/jkrMPRlot9BD8l7Qyaufhtq+bDQVnaCf3SiNoH
         37p5nVjYUc1RByUZWmioO9/FPBQ3Zh7A6A9YtqORvZ62eNDYn64jh7ChkDrQWKgrB5
         yGs16X40V0YlzXSDGs3oSjFmH7MrUmESjOO2DRfE=
Date:   Thu, 5 Aug 2021 12:49:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: include: Remove unused const
 definitions
Message-ID: <YQvCVZEU4WWLOdk9@kroah.com>
References: <20210802011025.23887-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802011025.23887-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 03:10:25AM +0200, Fabio M. De Francesco wrote:
> Remove unused const definitions. Issues detected by sparse. Remove the
> '#ifdef' and '#endif' preprocessor directives that surround them.

Can you now also remove the unneeded comments that reference these
variables as they make even less sense now?

thanks,

greg k-h
