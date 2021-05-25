Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA7B38FCC2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 10:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbhEYI3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 04:29:06 -0400
Received: from verein.lst.de ([213.95.11.211]:58161 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231504AbhEYI3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 04:29:03 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A35A868AFE; Tue, 25 May 2021 10:27:31 +0200 (CEST)
Date:   Tue, 25 May 2021 10:27:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] configfs: Implement the .read_iter and .write_iter
 callbacks
Message-ID: <20210525082731.GA19018@lst.de>
References: <20210520034521.16102-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520034521.16102-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Bart,

I've applied this, but split the unrelated kerneldoc fix into a separate
commit, and dropped the kerneldoc comments that did not document the API
entirely.
