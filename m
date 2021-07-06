Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E1E3BDB31
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 18:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhGFQPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 12:15:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:35134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229807AbhGFQPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 12:15:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 152AB61A11;
        Tue,  6 Jul 2021 16:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625587956;
        bh=vqX308HXSFL6SvZNuKllPzmcgOiyq5y2v4+kemo2cmw=;
        h=Date:From:To:Cc:Subject:From;
        b=DlapoBKuYP27hgszgQdorJQzDX57q+pmaiQylMb5YlTPOGxVZ7T2wC5R8ZmEMo3ev
         azjD/NCXX+bvs7XX7NFcqURP4kqc4WJU28u/uIMxrDtT4cqHzJDPwb2DNlUeffMF0W
         5dUy4g1o3GgEEefq86qXFNEEwsOGj2RuNk88iwSaP77Pbgy4iCrUM886JZvOFAZnWm
         mDPeKTdcwpm13tu50e0yj9TX4aMHFZ98cBYS+66MeEYQ9jwb35qqrX75a3KdcMSdKc
         7ZwfPhdFwkiGi65TUE4jZp8CoMtxUtKzQr6zoKcTlyFf2eMQKXeR7t3Vz2GxGeLsHw
         48VQCyK2wgJtw==
Date:   Tue, 6 Jul 2021 11:12:34 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>
Cc:     linux-alpha@vger.kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: add linux-alpha archives to lore.kernel.org?
Message-ID: <20210706161234.GA797557@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any interest in adding linux-alpha archives to
lore.kernel.org?  See https://korg.docs.kernel.org/lore.html for
details.

I don't know whether alpha is still viable.  Krzysztof has been
struggling to get a working alpha qemu and userspace working to do
boot testing of some PCI-related changes, and it's pretty hard.  But
maybe it's at least of historical interest, since alpha was one of the
first non-x86 ports?

Cc'd you, Eric, since you've done recent alpha fixes and apparently
have a bootable qemu-system-alpha:
https://www.spinics.net/lists/linux-alpha/msg07206.html

I don't have any of the old archives myself, but
http://marc.info/?l=linux-alpha and
http://www.spinics.net/lists/linux-alpha/ both seem to work.

Bjorn
