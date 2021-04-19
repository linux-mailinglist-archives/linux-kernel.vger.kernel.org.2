Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74AF6364EDB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 01:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbhDSXwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 19:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbhDSXwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 19:52:47 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A79C061763
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 16:52:13 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id a18so3738033qtj.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 16:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kepstin.ca; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Tvkr+mPSZ+ps5DppAGK1+r+Pdo4K4oVliDzSpuZeEcw=;
        b=CtItF8OToAHckxW4i9k8/+6ccOS+08mGOUvPXACScNE6B4Yei80WiWMj5Z50jJFjFF
         8KY3c1N+x+iIqe9M2Qm0AddKOZwF9SeUUNYdTji6732Wx0cyfspfvtECD5WAxvzhlQeg
         5gNThYBrSKuVUsxgjVac03LIJuO2eilwxkQE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Tvkr+mPSZ+ps5DppAGK1+r+Pdo4K4oVliDzSpuZeEcw=;
        b=pxKbTUkJX7k+EutSQrGkfsnT8TZzrITahaQfvAQo8pk6GilpnZK6yVmvihNG9QGGsH
         lOkyuygCMWnjnUPXhSNvLHVntyDEUPO+yW884C4K9WearFiEFTVzCLiVXVHlTVVSpKKi
         3cII/Dv1zb2wIrALwh7I9DVrDWU02rcJm92UI6kd9VRboKty3Q53tPWPAukIgy5/6iWu
         iXjQYktRQDlEm2C+BKI4vYBan+uB+M2/xi+DnnDKHKv5UsiXjUc0kPgpfbzuCcVQolBB
         zKzLs6D6redJsLovPgMwdZLQQDKe78Z3ky/A2nJc/Qb0BJlWz7x1ASb/+tJwnozBZPqG
         iCZw==
X-Gm-Message-State: AOAM5307y2cvuckg/ot+NChiO0ykxnZKA/EAZ+7VX75fToAD2l5YAu1e
        6RR2FUW4ZQKXxSp57EyZECEFUA==
X-Google-Smtp-Source: ABdhPJyyL46ChgPArznD6bCb/vCFF4f87AcabvZFleu+fYVN8dlJ33HXrIxgEFx6MEMvMN0ItHP9Vg==
X-Received: by 2002:a05:622a:6:: with SMTP id x6mr14131824qtw.1.1618876332119;
        Mon, 19 Apr 2021 16:52:12 -0700 (PDT)
Received: from [192.168.1.161] (dhcp-108-168-125-232.cable.user.start.ca. [108.168.125.232])
        by smtp.gmail.com with ESMTPSA id u11sm9934891qta.91.2021.04.19.16.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 16:52:11 -0700 (PDT)
Message-ID: <f2d4ba09466d00c8fe22531307d0057fd7c1860b.camel@kepstin.ca>
Subject: Re: [PATCH v2] tools/power turbostat: Fix RAPL summary collection
 on AMD processors
From:   calvin.walton@kepstin.ca
To:     Terry Bowman <terry.bowman@amd.com>, lenb@kernel.org,
        yu.c.chen@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, bp@suse.de
Cc:     wei.huang2@amd.com
Date:   Mon, 19 Apr 2021 19:52:09 -0400
In-Reply-To: <20210419195812.147710-1-terry.bowman@amd.com>
References: <20210419195812.147710-1-terry.bowman@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-04-19 at 14:58 -0500, Terry Bowman wrote:

@@ -3281,7 +3326,7 @@ static int update_msr_sum(struct thread_data *t, struct core_data *c, struct pkg
                        continue;
                ret = get_msr(cpu, offset, &msr_cur);
                if (ret) {
-                       fprintf(outf, "Can not update msr(0x%x)\n", offset);
+                       fprintf(outf, "Can not update msr(0x%lx)\n", offset);

This gives a warning when compiled on 32-bit, since turbostat is
compiled with -D_FILE_OFFSET_BITS=64:

turbostat.c: In function 'update_msr_sum':
turbostat.c:3329:42: warning: format '%lx' expects argument of type
'long unsigned int', but argument 3 has type 'off_t' {aka 'long long
int'} [-Wformat=]
 3329 |    fprintf(outf, "Can not update msr(0x%lx)\n", offset);
      |                                        ~~^      ~~~~~~
      |                                          |      |
      |                                          |      off_t {aka long long int}
      |                                          long unsigned int
      |                                        %llx

Easiest fix is probably to cast to (long long int) and use the %llx
format specifier. That should be valid with i686, x32, and amd64
userspace.

Everything else looks fine as far as I can tell, so feel free to add a

Reviewed-by: Calvin Walton <calvin.walton@kepstin.ca>

once you've fixed that warning.


-- 
 <calvin.walton@kepstin.ca>

