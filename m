Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB37742125A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 17:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbhJDPLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 11:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbhJDPLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 11:11:20 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B42C061745;
        Mon,  4 Oct 2021 08:09:31 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id s11so16807040pgr.11;
        Mon, 04 Oct 2021 08:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4WT++irZDfN01BalrLCtvvHYwTrUf+YL/bgNyWjc3v0=;
        b=E5OvtnIbeg650BaF6Hg+xcg00UoT67oerz+JsUrDVBfrPzwqAy7NH2lD37qeLN1KxB
         n1qUxPeVcXN2gvNyGvCntpvDMAzxqJcHNSNt41Pg3X1UJCWv2MltoJVaTh8JOs6C5fMI
         IIJ57zt1VC52AqjVMyWu3W9gAYWFy2Xv/eMp0uPkDCY+bk/1g2KGYM6ICVjHn74x0Pv/
         GZHMMU272Vtfumld/PctFVnoi//XobppLkTy+esHMaOgLQVTEq+yCJmV7UCCkb0DhFyZ
         GzhAALQFyys+zxBHVt1njPlBs63ZsgD2nWoYceo05/4hrf1fBJGJvWcxS8OrbZZoPIZJ
         vLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4WT++irZDfN01BalrLCtvvHYwTrUf+YL/bgNyWjc3v0=;
        b=tfiVWGOoU+EEwvLjmmEI+bJTiBWLNrEwAWFYOmwFo3PUV5MmLiAZ4PVSmetaBdTfDO
         sh3PRkA6bsLuMuk3fBkiFCIXeN0N+4giNyMfCrw57bcFo0u8pzKkrjuvbizwxabRMGt3
         jbWU2VnxIWJGicV97gnrqfPmM6gLe4lwnH4lbjMcLMwxh/i/H1qxFcH2D4Mq8JC8Yz9c
         acO9pGeG2dWepD8KS1ZubkovWUIv9tPTifOop3VsAZ+G+suquEfX++/KBL8B/t74HzmE
         +qhhcGpaTtcGbVKa+0M1rLcU6fyZUK8hG1/8OgGwZEt9i9mAmxCt5VUDvwmzxNAXbtjx
         iDBg==
X-Gm-Message-State: AOAM533yTlPkVOAWdqNFXAOVEUTTu+bVdjXRC00boDg67+oKEMzUg1CQ
        J9VzTGV+8mLwpREFb4DwXHd9A+Di5bI=
X-Google-Smtp-Source: ABdhPJydcUOr9uzsulpwFheZhE3wBfBrTBg57es9nQYryrxesZZxzB+cW06Oq7ejHfHNW0UKD75YBQ==
X-Received: by 2002:a05:6a00:15ca:b0:44c:767e:5850 with SMTP id o10-20020a056a0015ca00b0044c767e5850mr63306pfu.7.1633360170940;
        Mon, 04 Oct 2021 08:09:30 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id e17sm4727150pjh.17.2021.10.04.08.09.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Oct 2021 08:09:30 -0700 (PDT)
Subject: Re: [PATCH] drm/i915/guc, docs: Fix pdfdocs build error by removing
 nested grid
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <4a227569-074f-c501-58bb-d0d8f60a8ae9@gmail.com>
 <87czozba5c.fsf@intel.com>
From:   Akira Yokosawa <akiyks@gmail.com>
Message-ID: <3ec7d7c5-301f-ad34-fd40-844e81e1cdb9@gmail.com>
Date:   Tue, 5 Oct 2021 00:09:28 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87czozba5c.fsf@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Sep 2021 18:10:23 +0300, Jani Nikula wrote:
> On Mon, 20 Sep 2021, Akira Yokosawa <akiyks@gmail.com> wrote:
>> Nested grids in grid-table cells are not specified as proper ReST
>> constructs.
>> Commit 572f2a5cd974 ("drm/i915/guc: Update firmware to v62.0.0")
>> added a couple of kerneldoc tables of the form:
>>
>>   +---+-------+------------------------------------------------------+
>>   | 1 |  31:0 |  +------------------------------------------------+  |
>>   +---+-------+  |                                                |  |
>>   |...|       |  |  Embedded `HXG Message`_                       |  |
>>   +---+-------+  |                                                |  |
>>   | n |  31:0 |  +------------------------------------------------+  |
>>   +---+-------+------------------------------------------------------+
>>
>> For "make htmldocs", they happen to work as one might expect,
>> but they are incompatible with "make latexdocs" and "make pdfdocs",
>> and cause the generated gpu.tex file to become incomplete and
>> unbuildable by xelatex.
>>
>> Restore the compatibility by removing those nested grids in the tables.
>>
>> Size comparison of generated gpu.tex:
>>
>>                   Sphinx 2.4.4  Sphinx 4.2.0
>>   v5.14:               3238686       3841631
>>   v5.15-rc1:            376270        432729
>>   with this fix:       3377846       3998095
>>
>> Fixes: 572f2a5cd974 ("drm/i915/guc: Update firmware to v62.0.0")
>> Cc: John Harrison <John.C.Harrison@Intel.com>
>> Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
>> Cc: Matt Roper <matthew.d.roper@intel.com>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> 
> Pushed to drm-intel-gt-next, thanks for the patch.
> 
> This makes the HTML output arguably worse, but there were no comments
> from anyone and the pdf build needs to work.

[Dropped most CCs]

Hi Jani,

Thank you for taking care of this patch.

Jon, as this has reached upstream, can you back-merge v5.15-rc4
into docs-next so that "make pdfdocs" can complete?

I tried the back-merge without seeing any conflict.
"make pdfdocs" finishes successfully now.

        Thanks, Akira

> 
> BR,
> Jani.
> 
> 
> 
>> ---
[...]
