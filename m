Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C1C419835
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 17:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbhI0Pty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 11:49:54 -0400
Received: from verein.lst.de ([213.95.11.211]:47368 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235301AbhI0Ptx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 11:49:53 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2DE0267373; Mon, 27 Sep 2021 17:48:12 +0200 (CEST)
Date:   Mon, 27 Sep 2021 17:48:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
        linux-kernel@vger.kernel.org, axboe@kernel.dk,
        Sven Peter <sven@svenpeter.dev>,
        Orlando Chamberlain <redecorating@protonmail.com>,
        Aditya Garg <gargaditya08@live.com>
Subject: Re: [PATCHv2] nvme: add command id quirk for apple controllers
Message-ID: <20210927154812.GA9730@lst.de>
References: <20210927154306.387437-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927154306.387437-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Jens, given that you're on the thread, do you want to pick this up
directly to reduce the patch queue latency?
