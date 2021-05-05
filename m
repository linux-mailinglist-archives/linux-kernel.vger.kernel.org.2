Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6AC3746B7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 19:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237377AbhEERW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 13:22:56 -0400
Received: from smtprelay0211.hostedemail.com ([216.40.44.211]:44702 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237755AbhEERS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 13:18:29 -0400
Received: from omf06.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id A688C182CED34;
        Wed,  5 May 2021 17:17:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf06.hostedemail.com (Postfix) with ESMTPA id D7C832448B5;
        Wed,  5 May 2021 17:17:14 +0000 (UTC)
Message-ID: <3ba412f1c7c74639196d830939221b764284a24b.camel@perches.com>
Subject: Re: [PATCH] checkpatch: do not check for "/dev/null" while parsing
 addition of files
From:   Joe Perches <joe@perches.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        akpm@linux-foundation.org, apw@canonical.com
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 05 May 2021 10:17:13 -0700
In-Reply-To: <20210505081230.29190-1-manivannan.sadhasivam@linaro.org>
References: <20210505081230.29190-1-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D7C832448B5
X-Spam-Status: No, score=-2.71
X-Stat-Signature: qeedbxjif69ecw7eksd1xdbg6ze641xn
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19M7M7BIoYf2FvG3zEbW9caxnoDdkV2Iak=
X-HE-Tag: 1620235034-341205
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-05-05 at 13:42 +0530, Manivannan Sadhasivam wrote:
> "/dev/null" is used to signal created or deleted files in the diff header.
> While parsing the addition of files, checkpatch should look for
> "+++ b/file" and ignore "+++ /dev/null".

nack.  checkpatch shouldn't care about a/ b/ uses here.

> 
> Without this change, checkpatch falsely reports below warning for the
> patch that does devicetree YAML conversion:

Send me a copy of the source patch that creates this false positive.

> 
> ```
> WARNING: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst


