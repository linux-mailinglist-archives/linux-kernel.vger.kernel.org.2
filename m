Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F13D350FCE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 09:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbhDAHHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 03:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233258AbhDAHHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 03:07:35 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1B9C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 00:07:35 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lRrQM-005w1c-Qf; Thu, 01 Apr 2021 09:07:26 +0200
Message-ID: <474f71742eae52e16a2b46204b7fdb5ed05e192a.camel@sipsolutions.net>
Subject: Re: [PATCH 7/7] devcoredump: fix kernel-doc warning
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Date:   Thu, 01 Apr 2021 09:07:26 +0200
In-Reply-To: <20210331232614.304591-8-pierre-louis.bossart@linux.intel.com>
References: <20210331232614.304591-1-pierre-louis.bossart@linux.intel.com>
         <20210331232614.304591-8-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-03-31 at 18:26 -0500, Pierre-Louis Bossart wrote:
> remove make W=1 warnings
> 
> drivers/base/devcoredump.c:208: warning:
> Function parameter or member 'data' not described in
> 'devcd_free_sgtable'
> 
> drivers/base/devcoredump.c:208: warning:
> Excess function parameter 'table' description in 'devcd_free_sgtable'
> 
> drivers/base/devcoredump.c:225: warning:
> expecting prototype for devcd_read_from_table(). Prototype was for
> devcd_read_from_sgtable() instead

Thanks!

Reviewed-by: Johannes Berg <johannes@sipsolutions.net>

johannes


