Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8D6337889
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 16:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbhCKPyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 10:54:41 -0500
Received: from verein.lst.de ([213.95.11.211]:41584 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234101AbhCKPya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 10:54:30 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 80D7168B05; Thu, 11 Mar 2021 16:54:27 +0100 (CET)
Date:   Thu, 11 Mar 2021 16:54:27 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Martin Wilck <mwilck@suse.com>
Subject: Re: [PATCH v2] block: Suppress uevent for hidden device when
 removed
Message-ID: <20210311155427.GA23641@lst.de>
References: <20210311151917.136091-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311151917.136091-1-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
