Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536273BD60F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 14:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243047AbhGFM2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 08:28:37 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42354 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236533AbhGFMYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 08:24:03 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E9B9C2268E;
        Tue,  6 Jul 2021 12:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625574081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Aan1cXxL9cGbh1ZIWdDquBEBFJ6tOJ0dEGiZCExfdPk=;
        b=Gzk09SPy9r7nBaOoFRzQ1o4vTDZ7iPcOFQ1ohOQjGNbvSWq/jgngkFMSbN6mToryBZ3lWF
        u6VMkY331ZVy601UsysUGXESBNLZSYcR1Jfh5SGLNamu45LpLq7CWTG0yNbDuRhauWBDC8
        7uXVf43sir8hoYJZVj5WGNpTyaz2mgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625574081;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Aan1cXxL9cGbh1ZIWdDquBEBFJ6tOJ0dEGiZCExfdPk=;
        b=1jMACZT9F8Q3ycI2hz/rH/kIDTg2mcyNSDY5Ea2v++3lCNDte3a2PSHA4pH+9/1Bg06/gy
        Ny643wCDws67o3Cw==
Received: from localhost (unknown [10.163.25.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CAEE4A3EF0;
        Tue,  6 Jul 2021 12:21:21 +0000 (UTC)
Date:   Tue, 6 Jul 2021 14:21:21 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/2] nvme-fc: Wait with a timeout for queue to freeze
Message-ID: <20210706122121.qicyihexk2qawvef@beryllium.lan>
References: <20210625101649.49296-1-dwagner@suse.de>
 <20210625101649.49296-3-dwagner@suse.de>
 <YNp50pmlzN6M0kNX@T590>
 <20210705162519.qqlklisxcsiopflw@beryllium.lan>
 <YOQGRwLfLaFGqlVA@T590>
 <20210706081010.dqmg7bxik5gnym5k@beryllium.lan>
 <YOQYKn+POVR2g/h1@T590>
 <20210706085906.asz7cp7ydiid6yz5@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706085906.asz7cp7ydiid6yz5@beryllium.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A nvme_start_freeze() before nvme_wait_freeze() fixes the hangers. It is this
simple?
