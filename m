Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2069C354BF4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 07:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243699AbhDFEyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 00:54:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242529AbhDFEym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 00:54:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DC88613B7;
        Tue,  6 Apr 2021 04:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617684875;
        bh=3oXESt8oQgiKW/qAWnzICznc5KQKnQJ+Fw+d+XpBiUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ISUXBIjEtAuFGdfzBV8TvLh/0Kd1Xv1bB2XY2PGlKDxOsfdHlAnpU13cJv1hBDpf2
         6DXbaixwTlj+LaGvXqwFrmJt9fXOO/9GeZ5T8fBhYMF6jl/xeCiPvAmfsL5aLunqYW
         PKJVZIQQWXv4t9r50kUqv1KXByTR8fdk77i1TKlP51MWi5TlYwii6DK0J/LBKT0ofO
         G3rcF/be7Rqz8GmBkdUDKfoQ7fBGJjGXOFPxxbhSDBnYVg5eNO2muYbdIqUS9Zh0DN
         2APB0OrjOxkHOqZjCWHemaiBgiZv/KnIXwJTXBlWWCDIjQWiYXgTu5ls3CtpZI/Z62
         QwRWYfMPjtecg==
Date:   Tue, 6 Apr 2021 10:24:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2] soundwire: qcom: wait for fifo space to be available
 before read/write
Message-ID: <YGvph03m7w5DbATC@vkoul-mobl.Dlink>
References: <20210401090058.24041-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401090058.24041-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-04-21, 10:00, Srinivas Kandagatla wrote:
> If we write registers very fast we can endup in a situation where some
> of the writes will be dropped without any notice.
> 
> So wait for the fifo space to be available before reading/writing the
> soundwire registers.

Applied, thanks

-- 
~Vinod
