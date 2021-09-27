Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B912241980E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 17:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbhI0Plp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 11:41:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:44514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235100AbhI0Pln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 11:41:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1B4E160F6C;
        Mon, 27 Sep 2021 15:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632757205;
        bh=j+CKkGUGWTO8eYdtb3jkg0EQqw0sy92Yr/hAjQEmnAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=clVRMS8mohxD0Mm87m/nLRJxOOXVE7yywHbWPjg6XDp0FpvBXjW2bBcY46zDWzgsB
         goBIkBiJlNHlVkEU3g8SBiedTw6O3uD9pdO8IYE+MDRzr8PQ27eQ+r2hL46Yu8zVPw
         VRanyh0iZPkBfAiWHEfZGAaXlOJmus2VRYLbF1MI=
Date:   Mon, 27 Sep 2021 17:40:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Samuel Iglesias =?iso-8859-1?Q?Gons=E1lvez?= 
        <siglesias@igalia.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        industrypack-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] ipack: ipoctal: fix info leak and other bugs
Message-ID: <YVHl01zC49e3pgSv@kroah.com>
References: <20210917114622.5412-1-johan@kernel.org>
 <259e8411270f663352829e8df9af627d6fba4d1b.camel@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <259e8411270f663352829e8df9af627d6fba4d1b.camel@igalia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 07:49:45AM +0200, Samuel Iglesias Gonsálvez wrote:
> Hi Johan,
> 
> Thanks for the patch series!
> 
> Patch series is,
> 
> Acked-by: Samuel Iglesias Gonsalvez <siglesias@igalia.com>
> 
> Greg, Would you mind picking this patch series through your char-misc
> tree?

Now done.

I'll wait to take patch 6/6 after the first 5 go into Linus's tree as
that one is not needed for 5.15-final.

thanks,

greg k-h
