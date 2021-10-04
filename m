Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D45D42087D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 11:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhJDJlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 05:41:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230270AbhJDJlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 05:41:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 875C861248;
        Mon,  4 Oct 2021 09:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633340371;
        bh=ACHTWCiGRKZUussKStZLPz6zNs0ZnZlfOvpnSP7UEz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZBuKwEx/5jekVA5HNDujvF+MpORB7ZNTwtrv6fNgQzbzm0pXDORAXXfledrfHQJXe
         aPqWYxuc8z5oDR704QfsCoTS5lM+q5fzkTWG6kttorq7k8R7DkNIn37H9Nf6dMSZL5
         jRou0a+c2SJ1h9Akgs0/TsNLeVdEpXqNWFjMFxdHEJCLHJ35GIMZa4TtT/jjMoRNxF
         Tx8auSM4QwLCyAm74JEnxYZ0+Pmrd//qa/aIyRTA4dz+3zQ5VVyv2Um5JW9bpOPOR/
         AgJumuMbuok5f6GqmITJykhmX9NTDCamwN/vsKHxQUAq6/f7LmlZ1KqE9tUwLXRlrc
         kjLjglefYoaog==
Date:   Mon, 4 Oct 2021 10:39:26 +0100
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Fuad Tabba <tabba@google.com>,
        David Brazdil <dbrazdil@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 0/2] A couple of EL2 refcounts fixes
Message-ID: <20211004093925.GA27173@willie-the-truck>
References: <20211004090328.540941-1-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004090328.540941-1-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 10:03:12AM +0100, Quentin Perret wrote:
> This addresses a couple of issues Will has found with the refcounting of
> page-tables at EL2. Patch 01 fixes a nasty bug, and probably wants to go
> in -stable. Patch 02 fixes a small inconsistency which made it harder to
> find refcount-related bugs at EL2.
> 
> Feedback welcome !

For both patches:

Acked-by: Will Deacon <will@kernel.org>

Thanks!

Will
