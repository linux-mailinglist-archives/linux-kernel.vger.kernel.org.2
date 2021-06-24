Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABDE33B2EB9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 14:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhFXMSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 08:18:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50220 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhFXMSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 08:18:08 -0400
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out2.suse.de (Postfix) with ESMTP id 76ADF1FD35;
        Thu, 24 Jun 2021 12:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624536948;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WcsR1ZibJap2OoevdWUfx2YuyIyNYDHi4jfbSf83WqE=;
        b=RiF9Fz0Gd0yu5ItHRRYkWINJeYsEWEvr8xoTEbRuG76NQ1vfb3B4Rk/BE7+Pyjfjcspmwh
        V6cQbXbN/ufrwL94BgRlTZkl22GbqynK38QSyeQYZTAbG02qGyteJv52z3d9ysR+CN6HcB
        gysnYuHzZl8V2ijSMsZlgyRK3rpm15s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624536948;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WcsR1ZibJap2OoevdWUfx2YuyIyNYDHi4jfbSf83WqE=;
        b=mCskohEOS+tTexMFQtvKl8Pv9r/hb2/1dX9zbTqdj3dameIPSZtLCHyAjW3/Bya60HsrOP
        R8vN3TETFgTnYGCw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay1.suse.de (Postfix) with ESMTP id 6F0D625CC9;
        Thu, 24 Jun 2021 12:15:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 69A38DA8EB; Thu, 24 Jun 2021 14:12:56 +0200 (CEST)
Date:   Thu, 24 Jun 2021 14:12:56 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Benjamin LaHaise <ben@communityfibre.ca>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: linux-mm@kvack.org - limping on a backup
Message-ID: <20210624121256.GS28158@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Benjamin LaHaise <ben@communityfibre.ca>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210622145954.GA4058@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622145954.GA4058@kvack.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 10:59:54AM -0400, Benjamin LaHaise wrote:
> FYI: the filesystem hosting kanga.kvack.org which hosts linux-mm@kvack.org
> and a few other assorted things was damaged around 9:17am.  The mailing
> list is back up and running from a March 2nd backup for now.  The problem
> is either a bad SSD or a btrfs bug, however no crash dump was captured to 
> help with debugging.

Do you have any logs? Also when you have a suspicion that it was caused
by hardware, what's the SSD type? If you'd like a more interactive
discussion please come to the libera.chat #btrfs channel, there are
people with a lot of experience and knowledge about buggy hardware. In
case it's a btrfs bug we'd be interested to know at least something that
could help to narrow it down.

d.
