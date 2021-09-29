Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C20441C4F1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 14:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343896AbhI2Mut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 08:50:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:54038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343839AbhI2Mus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 08:50:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C94E7611C7;
        Wed, 29 Sep 2021 12:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632919747;
        bh=JeiSEjK+SVcwZshRvvopfOY5oWfNI5hLbqGqWH3MFz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mjkeT+NC0Hzhi7/EtJDr+GvHTtXTRKZZ7zBx2Vo067HE3plkIstwQ3i4AmUsPmC8x
         tLL4ot4I3dlnXbyZNEBfhVS98Wabx4EH9RdN2BvRnJx8EUtr+GvyXOQW6BR2x3BX2a
         ZUPQucVolNPKYKcyU/UPEpJHjQECed0diUyd5Wo0l29KJR0VW4P264+QqQHq4jPWvG
         Oav5qB5Zrg1QOg+kd+YEorGlyWM+BoyDpffWPtRc8XFiG2PLgSz3wEwV8Flqt2iNn4
         RMaLBoKsewgq/Vf8DxOHRTOtdWH4C3fjzlabWSqSYPB3+yMEtG/LUPwiulkLHWbrQP
         ul+9P54I2Fdyg==
Date:   Wed, 29 Sep 2021 13:49:00 +0100
From:   Will Deacon <will@kernel.org>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, tyhicks@linux.microsoft.com,
        kernelfans@gmail.com, akpm@linux-foundation.org,
        madvenka@linux.microsoft.com
Subject: Re: [PATCH v17 00/15] arm64: MMU enabled kexec relocation
Message-ID: <20210929124900.GE21631@willie-the-truck>
References: <20210916231325.125533-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916231325.125533-1-pasha.tatashin@soleen.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 07:13:10PM -0400, Pasha Tatashin wrote:
> Changelog:
> v17:
> 	- Merged with 5.15-rc1 as requested by Catalin Marinas
> 	- Added Tested-by: Pingfan Liu <piliu@redhat.com>

This looks pretty good to me. I've left some minor comments on a few of the
patches, but other than those I'd like to try getting these queued for
5.16.

Will
