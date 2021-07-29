Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACC23DA975
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 18:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhG2Qws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 12:52:48 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21336 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhG2Qwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 12:52:47 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1627577560; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=BsmWKq+5VCr2FsOe8rEynZpMqKTPxQLhfSREK11YYKMkFq9pj5wkUEmcuwOPynAJswpjVlDMcgXs82u07obaoqUcVpEnlYSqV1IBvP3uPLkbFDETsobI02tkAipushBqVObz10men0AOjCPYp3pwASo09SEWGF6a2gA1OJGsgfk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1627577560; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=CeMIoMGJKi5xWxjzK0BqJB0xLd4uAWj2QZ+Ixq0EaEc=; 
        b=RYULpI+KVCdXpIFdXZPWo3KeB4Ov7g41ch+tB3g3WPDJD4t+/EOM6VMhvO1HYFNz1FsOwnbOa1k+uvccALRP+WXaA5ylGxJINnFfKhomj7qnNcDwHcxwh4zu30rMEqpqqurOu5DhXkM+nEO1UQoA3vPPZco4/X3+Y5esBt/la6w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1627577560;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        bh=CeMIoMGJKi5xWxjzK0BqJB0xLd4uAWj2QZ+Ixq0EaEc=;
        b=RuShqD9poBj0Om5UXYEtnjIndUCzvUuDnBa0AytduYlMm++/+Py0on5fgfFvaH+w
        jRsy5K36G0nFiD8Ly6yx4gMikuEkBCC7mml+GnVPPqkEHrnwAVz2cBeIERAePZsnpZ7
        +vUFzG9o/MtDhQEBs/RgGANhSKGn2bKqazSwJuyE=
Received: from anirudhrb.com (106.51.105.90 [106.51.105.90]) by mx.zohomail.com
        with SMTPS id 162757755916951.49160872968753; Thu, 29 Jul 2021 09:52:39 -0700 (PDT)
Date:   Thu, 29 Jul 2021 22:22:33 +0530
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v8 0/2] firmware_loader: fix uaf in
 firmware_fallback_sysfs
Message-ID: <YQLc0UYXSjqbARAJ@anirudhrb.com>
References: <20210728085107.4141-1-mail@anirudhrb.com>
 <YQG/9RPgETxF08Vz@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQG/9RPgETxF08Vz@bombadil.infradead.org>
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 01:37:09PM -0700, Luis Chamberlain wrote:
> On Wed, Jul 28, 2021 at 02:21:05PM +0530, Anirudh Rayabharam wrote:
> > This series fixes the use after free in firmware_fallback_sysfs reported by
> > syzbot at: 
> > https://syzkaller.appspot.com/bug?extid=de271708674e2093097b
> 
> Greg,
> 
> With Shua's review ammeded, this series is ready to be queued up, finally.
> 
> Anirudh, thanks for following up on all these iterations!

Thank you for your guidance throughout this series!

	- Anirudh.
