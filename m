Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A05C3AFEB2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 10:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhFVIGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 04:06:54 -0400
Received: from verein.lst.de ([213.95.11.211]:45561 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230206AbhFVIGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 04:06:51 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B8C4E67373; Tue, 22 Jun 2021 10:04:33 +0200 (CEST)
Date:   Tue, 22 Jun 2021 10:04:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Chung-Chiang Cheng <shepjeng@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, jlbec@evilplan.org,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chung-Chiang Cheng <cccheng@synology.com>
Subject: Re: [PATCH] configfs: fix memleak in configfs_release_bin_file
Message-ID: <20210622080432.GA2232@lst.de>
References: <20210618075925.803052-1-cccheng@synology.com> <20210622060419.GA29360@lst.de> <CAHuHWt=2ZoQJz1tVpJ7SzqUDwPXthNHksq2-uTFCzHmv+E7qWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHuHWt=2ZoQJz1tVpJ7SzqUDwPXthNHksq2-uTFCzHmv+E7qWA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks.  I'v split this into one to move the vfree attribute to you
and a cleanup on top and applied the result to the configfs tree:

http://git.infradead.org/users/hch/configfs.git/shortlog/refs/heads/for-next
