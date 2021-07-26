Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9423D5914
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 14:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbhGZLVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 07:21:34 -0400
Received: from mx1.tq-group.com ([93.104.207.81]:38285 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233604AbhGZLVZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 07:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1627300914; x=1658836914;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yerRSQV6BHo5/MlTfGuWZsA6nVXmeK7jDP3qdLSGjvo=;
  b=Ja8eIGqlJe3LaB26c1elxl0/wnCnOlG9wGik9HlyV94YuHp3Llj2OBGX
   CGZhBbj27H4El1Z9tDT6/wg5r5iulTa3JdR44nNlb2Yh+9t3NGqA2P5rl
   uXN9/r6PBB0HVx8w/Gt0vSEIzyIdNfatmsOKSaCx+b9OOJeteqXgspOQw
   2w/EHSiMSE/eQzePjWRS9zU8WcVfusJgnidRyAXf5bHQUvsnjzpWpSnm7
   ttpxDIyq1XYgu7ZWpZuJFqPP36t0wTIYMdLcjE6QRjVjsEtJs7BEDPjOp
   MSIFllIi8BtZhnRpNny7jsngCY7ps6PCTx52Fd0RyZTW2IRzVjoeLbuTh
   g==;
X-IronPort-AV: E=Sophos;i="5.84,270,1620684000"; 
   d="scan'208";a="18639422"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 26 Jul 2021 14:01:53 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 26 Jul 2021 14:01:53 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 26 Jul 2021 14:01:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1627300913; x=1658836913;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yerRSQV6BHo5/MlTfGuWZsA6nVXmeK7jDP3qdLSGjvo=;
  b=hfWBjPaDp0H+uWY8sZBMcgEmt6lXWS+7CPj7dgt5oi2C7scUBwgKAeld
   Ii+C3QpzdbzMRjxR8h9Haa0o1GGlsR1qFs2ByusxzzHwRWiyQAvmdbgA6
   3ARiGO0RNk1YBFJWwQLHm36qZSVjtI6/ezJ3jXIFmfDFv7VuazvHfJQA6
   V+MKX+uyXb6mokmVYlFf3xDalWJntfxhka03OW9i6owWUQwbAgwD4AGmO
   IoHrqqXViZGbw21r42QsqInPwmFannFAKbx4C5Pvb2Zt+WPPGiDFfTDPt
   9CjmmP04LDpq1lpRL+MEx8iRj1Itv+i7vj9OVcoTootExfsKv1FU0+v72
   w==;
X-IronPort-AV: E=Sophos;i="5.84,270,1620684000"; 
   d="scan'208";a="18639421"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 26 Jul 2021 14:01:53 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.121.48.12])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 4F524280070;
        Mon, 26 Jul 2021 14:01:53 +0200 (CEST)
Message-ID: <7b54590fddf167744fa2574d8815130608f8e063.camel@ew.tq-group.com>
Subject: Re: [PATCH] regmap: do not call regmap_debugfs_init() from
 regmap_attach_dev()
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        David Lechner <david@lechnology.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 26 Jul 2021 14:01:51 +0200
In-Reply-To: <20210726114751.GE4670@sirena.org.uk>
References: <20210726073627.31589-1-matthias.schiffer@ew.tq-group.com>
         <20210726114751.GE4670@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-07-26 at 12:47 +0100, Mark Brown wrote:
> * PGP Signed by an unknown key
> 
> On Mon, Jul 26, 2021 at 09:36:27AM +0200, Matthias Schiffer wrote:
> > regmap_debugfs_init() should never be called twice for the same regmap,
> > as it initializes various fields of the regmap struct, including list
> > heads and mutices. A visible symptom are messages like:
> > 
> >     debugfs: Directory 'dummy-iomuxc-gpr@20e4000' with parent 'regmap'
> >     already present!
> > 
> > This happened whenever regmap_attach_dev() was called for an existing
> > regmap. Remove the call from regmap_attach_dev() and change
> > __regmap_init() so that regmap_debugfs_init() is called exactly once.
> 
> The use case for regmap_attach_dev() is that there was no device when
> the regmap was initially instantiated due to it running very early, we
> want to attach the device when we figure out what it is which includes
> setting up the debugfs stuff.  Whatever is managing to call this with
> the same device as has already been set is clearly not that use case.
> 
> 

Hi Mark,

I'm not talking about a case where regmap_attach_dev() is called when
there is already a device attached; as far as I can tell such a thing
does not happen in current kernel code.

Please have a look at the commit in the Fixes: tag. The duplicate
regmap_debugfs_init() happens even when no device was passed in
__regmap_init(), so the regmap_attach_dev() is the first time a device
it attached.

