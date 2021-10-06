Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F385424174
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 17:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbhJFPkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 11:40:31 -0400
Received: from smtprelay0095.hostedemail.com ([216.40.44.95]:50888 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230014AbhJFPka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 11:40:30 -0400
Received: from omf01.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 89CC1837F24D;
        Wed,  6 Oct 2021 15:38:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id E1EE21727B;
        Wed,  6 Oct 2021 15:38:35 +0000 (UTC)
Message-ID: <60166c1bbd4cc261cdad7b22f6ccb5bf73e64956.camel@perches.com>
Subject: Re: [PATCH] Documentation: Fix typo in sysfs-driver-ufs
From:   Joe Perches <joe@perches.com>
To:     Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bean Huo <beanhuo@micron.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Can Guo <cang@codeaurora.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <avri.altman@wdc.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 06 Oct 2021 08:38:34 -0700
In-Reply-To: <20211006143506.129409-1-sohaib.amhmd@gmail.com>
References: <20211006143506.129409-1-sohaib.amhmd@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: E1EE21727B
X-Spam-Status: No, score=1.60
X-Stat-Signature: 8zp66mzoft49kksrjhye67t13k4hxi7f
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18rnQxkU03cMZFmooO27HthCG9Om5CuVUw=
X-HE-Tag: 1633534715-469353
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-10-06 at 16:35 +0200, Sohaib Mohamed wrote:
> Remove repeated world: "the The amount"
> 
> Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-driver-ufs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
> index 863cc4897277..57aec11a573f 100644
> --- a/Documentation/ABI/testing/sysfs-driver-ufs
> +++ b/Documentation/ABI/testing/sysfs-driver-ufs
> @@ -983,7 +983,7 @@ Description:	This file shows the amount of data that the host plans to
>  What:		/sys/class/scsi_device/*/device/dyn_cap_needed
>  Date:		February 2018
>  Contact:	Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
> -Description:	This file shows the The amount of physical memory needed
> +Description:	This file shows The amount of physical memory needed

Please instead remove the 'The' use.

Description:	This file shows the amount of physical memory needed


