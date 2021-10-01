Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCD541E6D0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 06:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237841AbhJAEiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 00:38:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:51058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230477AbhJAEh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 00:37:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67D4961A38;
        Fri,  1 Oct 2021 04:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633062976;
        bh=o7W1TWKuuUspAw3IemuWpxXTM4VfuLgUo2O3Ksw9J00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ylx4QoGbMO0nWymDopNL2clFS0/KWpaxzYmulpGUoQFcW3Y0ZpaHswhtkriHkFv06
         O0cGlpHdAoEaljl2rt5iLkLARuHLlxcHSMnhlaG/SFEX7zvc2jMcM4VHsRMnJ4jzRz
         Hjocy/SqYtKBi6+IcWHdJFnv+yAqm8Xw6a3uUL/3Vzoiemb3OxiTsGxGFUfbqW295Q
         mBFsBAjsqRuu2wVZw/6+n+z2QwK+01OorWokyDggUIXM7W0ruimDjtfyTGlpa9PcPf
         sFEZYzhWcmNUKlhTgNm5OZwg6Uei9eQ/I80VNP/XhDnmjQXMfGbl9jQlJ129h5ZIR4
         FkQRQW2YOfNgA==
Date:   Fri, 1 Oct 2021 10:06:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 16/30] ABI: sysfs-bus-soundwire-slave: use wildcards
 on What definitions
Message-ID: <YVaQO2VUEtnMi91m@matsya>
References: <cover.1631782432.git.mchehab+huawei@kernel.org>
 <416f4a746c116147abb08fb0155a6a4ed065dfd7.1631782432.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416f4a746c116147abb08fb0155a6a4ed065dfd7.1631782432.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-09-21, 10:59, Mauro Carvalho Chehab wrote:
> An "N" upper letter is not a wildcard, nor can easily be identified
> by script, specially since the USB sysfs define things like.
> bNumInterfaces. Use, instead, <N>, in order to let script/get_abi.pl
> to convert it into a Regex.

Applied, thanks

-- 
~Vinod
