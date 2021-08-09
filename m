Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E653E4835
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 16:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbhHIO5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 10:57:24 -0400
Received: from verein.lst.de ([213.95.11.211]:60875 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234969AbhHIO5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 10:57:23 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D071A67357; Mon,  9 Aug 2021 16:56:59 +0200 (CEST)
Date:   Mon, 9 Aug 2021 16:56:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Joel Becker <jlbec@evilplan.org>,
        linux-kernel@vger.kernel.org,
        Bodo Stroesser <bostroesser@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v4 0/3] Restore the kernel v5.13 text attribute write
 behavior
Message-ID: <20210809145659.GA21234@lst.de>
References: <20210805043503.20252-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805043503.20252-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

I've applied patch 1 and will send it to Linus this week.

Patch 2 seems like something that should go through the kunit tree,
and if we do so patch 3 should go along with that.
