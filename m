Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27B6437C093
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 16:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhELOri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 10:47:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:45174 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230202AbhELOrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 10:47:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C326EAECB;
        Wed, 12 May 2021 14:46:28 +0000 (UTC)
Date:   Wed, 12 May 2021 16:46:28 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Enzo Matsumiya <ematsumiya@suse.com>
Subject: Re: [PATCH v2] nvmet: Reset ns->file when open fails
Message-ID: <20210512144628.ofxf5rwjwytcjiip@beryllium.lan>
References: <20210512144228.103396-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512144228.103396-1-dwagner@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Argh, obvious failed again....
