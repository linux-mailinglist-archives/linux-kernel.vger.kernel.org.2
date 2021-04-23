Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53021368E0B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 09:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241122AbhDWHnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 03:43:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:47826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229456AbhDWHnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 03:43:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B10B613B2;
        Fri, 23 Apr 2021 07:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619163758;
        bh=0tsV4fv8ZUNymt76995znxxe3Nf6cIyK9zknlMKIt1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FeayGH0zmITlT6vbtMDR9PKMElGo4x+uldqkfwub9XrUy1w2cntDOuUhZM0Y2twOP
         s8weDHYjs0wlzM3YP3d7Rkuis5uYvQ8y/rgYQ2ERZL9F1KOCZBJfZbukXBwtEy9pbo
         rZ3sA2t9ft061I/s/x3eLYrmbRrGeUdpQI2HNPXg=
Date:   Fri, 23 Apr 2021 09:42:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Shyam Prasad <Shyam.Prasad@microsoft.com>
Cc:     Salvatore Bonaccorso <carnil@debian.org>, pc <pc@cjr.nz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Aurelien Aptel <aaptel@suse.com>,
        Steven French <Steven.French@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH 4.19 013/247] cifs: Set
 CIFS_MOUNT_USE_PREFIX_PATH flag on setting cifs_sb->prepath.
Message-ID: <YIJ6a77TVaZGzQIg@kroah.com>
References: <YGxIMCsclG4E1/ck@eldamar.lan>
 <YGxlJXv/+IPaErUr@kroah.com>
 <PSAP153MB04220682838AC9D025414B6094769@PSAP153MB0422.APCP153.PROD.OUTLOOK.COM>
 <YGx3u01Wa/DDnjlV@eldamar.lan>
 <YG7r0UaivWZL762N@eldamar.lan>
 <YHP+XbVWfGv21EL1@kroah.com>
 <YHwo5prs4MbXEzER@eldamar.lan>
 <PSAP153MB04224202F4A2BE668533F94794499@PSAP153MB0422.APCP153.PROD.OUTLOOK.COM>
 <YH25PZn5Eb3qC6JA@eldamar.lan>
 <PSAP153MB04225D77E22AFC17C4AEA52E94469@PSAP153MB0422.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSAP153MB04225D77E22AFC17C4AEA52E94469@PSAP153MB0422.APCP153.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 03:36:07PM +0000, Shyam Prasad wrote:
> Hi Salvatore and Santiago,
> 
> Thanks for testing this out.
> 
> @Greg Kroah-Hartman: The reverted patch used in combination with Paulo's fix seems to fix both use cases. 
> Can we have both these taken in on stable kernels? Paulo's patch is needed only for kernels 5.10 and older.

I do not know what "both" is here at all.

Please resubmit all of the needed commits in a format that I can apply
them in, and I will be glad to review them and queue them up.

Note, patches that are not in Linus's tree better be documented really
really really really well for why that is not so...

thanks,

greg k-h
