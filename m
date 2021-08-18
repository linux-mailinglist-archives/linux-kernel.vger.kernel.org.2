Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C79F3EFA1D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 07:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237822AbhHRFdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 01:33:38 -0400
Received: from verein.lst.de ([213.95.11.211]:60649 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236055AbhHRFdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 01:33:37 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id AED7067357; Wed, 18 Aug 2021 07:33:00 +0200 (CEST)
Date:   Wed, 18 Aug 2021 07:33:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3 1/3] fs/ntfs3: Fix one none utf8 char in source file
Message-ID: <20210818053300.GA9165@lst.de>
References: <20210818010649.412912-1-kari.argillander@gmail.com> <20210818010649.412912-2-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818010649.412912-2-kari.argillander@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 04:06:47AM +0300, Kari Argillander wrote:
> In one source file there is for some reason non utf8 char. But hey this
> is fs development so this kind of thing might happen.

Pleaese also refomat these comments while you're at it.  While going
over 80 characters is ok in exceptions for readability that is per
definition never the case for a block comment.
