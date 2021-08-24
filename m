Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA753F599F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 10:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235363AbhHXIFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 04:05:17 -0400
Received: from verein.lst.de ([213.95.11.211]:50686 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235307AbhHXIEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 04:04:48 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6604868AFE; Tue, 24 Aug 2021 10:03:47 +0200 (CEST)
Date:   Tue, 24 Aug 2021 10:03:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Kari Argillander <kari.argillander@gmail.com>
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christoph Hellwig <hch@lst.de>, ntfs3@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v2 6/6] fs/ntfs3: Rename mount option no_acl_rules >
 (no)acl_rules
Message-ID: <20210824080346.GE26733@lst.de>
References: <20210819002633.689831-1-kari.argillander@gmail.com> <20210819002633.689831-7-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819002633.689831-7-kari.argillander@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 03:26:33AM +0300, Kari Argillander wrote:
> Rename mount option no_acl_rules to noacl_rules. This allow us to use
> possibility to mount with options noacl_rules or acl_rules.
> 
> Signed-off-by: Kari Argillander <kari.argillander@gmail.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
