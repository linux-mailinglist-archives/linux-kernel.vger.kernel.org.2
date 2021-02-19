Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2526C31FE66
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 18:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhBSRye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 12:54:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:40858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229774AbhBSRy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 12:54:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4838B64E86;
        Fri, 19 Feb 2021 17:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613757226;
        bh=FX13Zn983HudfRRhXLlwksuMK8K2kTf+GC5FFze6dW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AS48eQBy3qg5fbju5705xyjB84tDvxxqOM/o85qwfo25QQ+AHQ2196vl5gzUede5h
         d7ZJKeG8j/Ee6vIspMFpwTmkABFwPQ8t8rz3yh/3JoMGuKzh5QfGTiH3LgEiw1yqo2
         IMGVz6UozE5vRgrrEAAgQkj1GAzWzZC67mO/Drnxj5SISRZIaWZsUQ/4tI6aqSOF6p
         rkwa/2CXZrVh/qPIGNRcYwdmWszUkwM8mDOFWL3u/gCsxSIHZ7vUtn1NOkWbcqoFaa
         Oblwe3TTSCVpXBfLdxweScFRtER04PyQekvtfGjadRY0tHrMBXu2mvGAb7iZc+jONO
         4a2vA8Sm6VxpA==
Date:   Fri, 19 Feb 2021 17:53:42 +0000
From:   Will Deacon <will@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-arm-kernel@lists.infradead.org, jmorris@namei.org,
        linux-kernel@vger.kernel.org, tyhicks@linux.microsoft.com,
        james.morse@arm.com, ebiederm@xmission.com,
        kexec@lists.infradead.org
Subject: Re: [PATCH 1/1] kexec: move machine_kexec_post_load() to public
 interface
Message-ID: <20210219175341.GC6352@willie-the-truck>
References: <20210215185908.257724-1-pasha.tatashin@soleen.com>
 <20210215185908.257724-2-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210215185908.257724-2-pasha.tatashin@soleen.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 01:59:08PM -0500, Pavel Tatashin wrote:
> machine_kexec_post_load() is called after kexec load is finished. It must
> be declared in public header not in kexec_internal.h

Could you provide a log of what goes wrong without this patch, please?

> Reported-by: kernel test robot <lkp@intel.com>

Do you have a link to the report, or did it not go to the list?

Will
