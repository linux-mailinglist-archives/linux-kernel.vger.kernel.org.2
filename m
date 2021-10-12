Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E6E429FA0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 10:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbhJLIWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 04:22:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:52084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232541AbhJLIVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 04:21:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C27A6101D;
        Tue, 12 Oct 2021 08:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634026794;
        bh=lDPufYSiKyvGGDrYONfULzGOTQL591ZiKQDt8MPRrw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EbhrCQT6mNhvQPiAFl8cNGZj7me7jYjv8/NCbzUy/aKo5RfWSXhn4M4I78GlMhNRN
         pruhFBcjfGZcQkqF+4MPON1fwgpXBNmSoDzYF/fF4/0mYUDH3g6ZXPuATahOpCcOgq
         +q0S6w9teF4Kw+i2PtOTccVI0E/N4LIvGostQHdf+3j1mApKvEZyDRr7DlVJHOTpCE
         nx5qm85PGJTFzlTIBreR9gDbjD/K+a/s0oVk3UIkQOQh6bgoQImCGJ4ckusQxKlJ/D
         eAqfvgiMXVFt82AgIP8Y/awQPdli5FYtnaEAdAkxd4wg6pPT4RTUZVzqLF0EI5mlCy
         rDeHnI04DOUdw==
Date:   Tue, 12 Oct 2021 09:19:48 +0100
From:   Will Deacon <will@kernel.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        James Clark <James.Clark@arm.com>
Subject: Re: [PATCH 4/5] perf arm-spe: Implement find_snapshot callback
Message-ID: <20211012081948.GA5156@willie-the-truck>
References: <20210916154635.1525-1-german.gomez@arm.com>
 <20210916154635.1525-4-german.gomez@arm.com>
 <20210923135016.GG400258@leoy-ThinkPad-X240s>
 <20210923144048.GB603008@leoy-ThinkPad-X240s>
 <1c6a3a73-27dc-6673-7fe7-34bc7fcb0a68@arm.com>
 <20211004122724.GC174271@leoy-ThinkPad-X240s>
 <6b092f13-832f-5d1d-a504-aea96c81bf17@arm.com>
 <20211006095124.GC14400@leoy-ThinkPad-X240s>
 <377b54ef-b9c0-9cfc-ef0c-0187d7c493cc@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <377b54ef-b9c0-9cfc-ef0c-0187d7c493cc@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 04:55:37PM +0100, German Gomez wrote:
> Hi Leo,
> 
> On 06/10/2021 10:51, Leo Yan wrote:
> > On Wed, Oct 06, 2021 at 10:35:20AM +0100, German Gomez wrote:
> >
> > [...]
> >
> >>> So simply say, I think the head pointer monotonically increasing is
> >>> the right thing to do in Arm SPE driver.
> >> I will talk to James about how we can proceed on this.
> > Thanks!
> 
> I took this offline with James and, though it looks possible to patch
> the SPE driver to have a monotonically increasing head pointer in order
> to simplify the handling in the perf tool, it could be a breaking change
> for users of the perf_event_open syscall that currently rely on the way
> it works now.
> 
> An alternative way we considered to simplify the patch is to change the
> logic inside the find_snapshot callback so that it records the entire
> contents of the aux buffer every time.
> 
> What do you think?

What does intel-pt do?

Will
