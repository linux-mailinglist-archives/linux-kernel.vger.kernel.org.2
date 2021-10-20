Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA4C4347B3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 11:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhJTJQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 05:16:37 -0400
Received: from first.geanix.com ([116.203.34.67]:37396 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhJTJQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 05:16:36 -0400
Received: from skn-laptop (unknown [185.233.254.173])
        by first.geanix.com (Postfix) with ESMTPSA id BA31EC7EE1;
        Wed, 20 Oct 2021 09:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1634721260; bh=ZabwtyWaVUk5ppsPWi4gApmZlTAIjycNIe5rm6VQtHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=i4srVLdEtbJ23PO4E2matoE2PZy7M6NVHaT5kwgviXCeKwl/odiN0UwbhmxcL6Sex
         9LzP9zgOKJNXRvJJArLCLHeul4oW8EfhjYPuaZKfFXrBrPtQHbQwYq03iQR7xnb5D7
         lF/uXBTpFnV03kmsWsvZwhJjH4UKI+FbSIKBE1W/3yan9OKWyvI8SVmgwgqs3pVPwj
         ar0FbtlIY/2ry4+by82gEmhYgtLt/0YUCSY1DpNp4vL3+9Tf2J+sDWQ78M9FssoDJe
         /ymJ0WY9gIv9G0nM+CKkM2xkCE//osuIFZDM3LpAOaaoLmX2v3bRj3jDW331NIzvwy
         EvOQUysYwZgKg==
Date:   Wed, 20 Oct 2021 11:14:19 +0200
From:   Sean Nyekjaer <sean@geanix.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] mtd: rawnand: remove suspended check
Message-ID: <20211020091419.2ufd4modeopmpxsp@skn-laptop>
References: <20211020084534.2472305-1-sean@geanix.com>
 <20211020084534.2472305-4-sean@geanix.com>
 <20211020105743.225d97f4@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211020105743.225d97f4@collabora.com>
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 10:57:43AM +0200, Boris Brezillon wrote:
> On Wed, 20 Oct 2021 10:45:33 +0200
> Sean Nyekjaer <sean@geanix.com> wrote:
> 
> > Access is protected in upper MTD layer when MTD devices are suspended.
> 
> I think it deserves more explanation.
> 

Access is protected in upper MTD layer when MTD devices are suspended.

Commit ("mtd: core: protect access to MTD devices while in suspend")
introduces access protection, so it's safe to remove suspended checks.
