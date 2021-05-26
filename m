Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F61C391186
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 09:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhEZHxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 03:53:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229594AbhEZHxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 03:53:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7167B6143C;
        Wed, 26 May 2021 07:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622015541;
        bh=OBhC16CeKXkxGfxD2gxqduLx6bT2Kgln+ftnIWZx584=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IZV9HOYfdm4Xx+zJnJV9uaxU9N5AAPG0HJvGfUnnawLd49rf/apmrvS3DqY0HZAyL
         NKj9yCjgnKm3NZf9R69mIaOzaTxB6g6anZYRPUMax+GFpqrJQb/5CKzWYqmzAudg1x
         LMuEza91Qc2MUklJvTkZWShbg4JraKsHq9zGm9b3Brh4kRJx1b46rBihQSaDqGqBc6
         YuTTTcyMmuCKs2/u7zTUtEnSPphQ5i0TAfPm/yciWDoWVavRZ1z1w6JC9V2xEpozlz
         DzfZqpSlLB/UV7LXpYJrhfLqupJpnToavRYZYp78HWSjdeuT8xgC8EA7p3QHezkqc1
         j5lvMHwjlzwaQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1lloKv-0003AC-VX; Wed, 26 May 2021 09:52:18 +0200
Date:   Wed, 26 May 2021 09:52:17 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Alexandre GRIVEAUX <agriveaux@deutnet.info>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 1/2] USB: serial: omninet: Adding Zyxel Omni 56K
 Plus
Message-ID: <YK3+MeWhz49YR3/u@hovoldconsulting.com>
References: <20210523163522.1690-1-agriveaux@deutnet.info>
 <YKyg2EYDn2BEnvYU@hovoldconsulting.com>
 <20210525092534.GA7238@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525092534.GA7238@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 11:25:34AM +0200, Alexandre GRIVEAUX wrote:
> On Tue, May 25, 2021 at 09:01:44AM +0200, Johan Hovold wrote:
> > On Sun, May 23, 2021 at 06:35:21PM +0200, Alexandre GRIVEAUX wrote:
> > > Adding Zyxel Omni 56K Plus modem, this modem include:

> > Also, why is there a RESEND prefix in the subject? This is the first
> > time I see this patch.
> 
> For the RESEND, I have a residual mailname file with
> "localhost.localdomain" inside, i've checked log, some address received
> messages, so i've changed the subject prefix to "resend". sorry for
> that.

Ah, ok, no worries at all. Just thought I may had missed the first
submission.

Johan
