Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C378F3233F8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 23:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbhBWWxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 17:53:10 -0500
Received: from linux.microsoft.com ([13.77.154.182]:37036 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbhBWWiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 17:38:18 -0500
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 011C320B6C40;
        Tue, 23 Feb 2021 14:36:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 011C320B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1614119814;
        bh=u8xSV6mboWtDGea5Rur1TvDYanYtddwU8NnszQ/n/XA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l/juN9thNxAd+EYyH2zmk6LCkANs5rgZ751fxC58hTY839paqQO8z7oWj+iPq/kUB
         MQ5YVFmUd5adAA3Ysaepwv+AUZWmU8DDrNvSjgf/zge+oqVPplWvj9VfM1CnK9pUWQ
         b4TajhAW7wa29NG/JafB93KZ2bPQuMyrm6+R0hFg=
Date:   Tue, 23 Feb 2021 16:36:52 -0600
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Race between policy reload sidtab conversion and live
 conversion
Message-ID: <20210223223652.GD6000@sequoia>
References: <20210223214346.GB6000@sequoia>
 <20210223215054.GC6000@sequoia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223215054.GC6000@sequoia>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-23 15:50:56, Tyler Hicks wrote:
> On 2021-02-23 15:43:48, Tyler Hicks wrote:
> > I'm seeing a race during policy load while the "regular" sidtab
> > conversion is happening and a live conversion starts to take place in
> > sidtab_context_to_sid().
> > 
> > We have an initial policy that's loaded by systemd ~0.6s into boot and
> > then another policy gets loaded ~2-3s into boot. That second policy load
> > is what hits the race condition situation because the sidtab is only
> > partially populated and there's a decent amount of filesystem operations
> > happening, at the same time, which are triggering live conversions.

Hmm, perhaps this is the same problem that's fixed by Ondrej's proposed
change here:

 https://lore.kernel.org/selinux/20210212185930.130477-3-omosnace@redhat.com/

I'll put these changes through a validation run (the only place that I
can seem to reproduce this crash) and see how it looks.

Tyler
