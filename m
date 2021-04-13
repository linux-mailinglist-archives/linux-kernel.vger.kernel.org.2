Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D8535DE63
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 14:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345443AbhDMMM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 08:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345437AbhDMMM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 08:12:27 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C84C061756
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 05:12:07 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id l4so25491644ejc.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 05:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=TpxC1qelb9qRujqf8xDlcIHAF8+xB1dypj9reMWQZ4o=;
        b=QrIoSxI4gJ/KgVGb4hCt1Y4h4rP8zc8j5m9Sz+/eXvN2p7vKPdREwZPBSaUxMsN26x
         DaeI//cyb3Iu8krLI4pMyrOGe9j3K3i6f+ODoNnCjwl0p6CDJYh/edkLPTVVMAsJcfU9
         UM7AigVQlZ5dXC4CfhDgrt/pEnC8nJs3K5fUE0g8ToSinapnaUsPSQAABQPU35yFy7NU
         j1eTXDA6wiyk+D3MpM/aIhep4KZu9JYftozPtBEvYByP1OATA19sz/+gk/eY+hV6xj8e
         u9+M3O3BxuEq4lGgSc+XuLGb5OJtE5ylh5dwB2eJDwg+n2JNlQFlZpIDl9RdDcHLNBcQ
         6cBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=TpxC1qelb9qRujqf8xDlcIHAF8+xB1dypj9reMWQZ4o=;
        b=KvgQbFDUA+s52MRe9Z/6Ypco8+LUZ6feQbaRVqzb5yABOHXoPMAHMEigrYyJfW778l
         7ECZo00KbAzr7YBVI1sPQoHLOur6Wplv5DMvj515RaALu/7wWeHRJJcz4KGP/wgS2yJ2
         uxCDd7opGhzB9fyhleTxPhSwO0S4rCJXbSNMlXXrXJQQMBpREUIfDatF0LogGcz2oRsb
         vlFVmxeShe+2yUQBbWRw/NqcpDQBQjw80IDik0UbAt/V/3tbG+QhUy7tT664GN+X3JMc
         DpLsqnPK96gvLjupS/nfMWw50y5s8xyMWASasJPI9nMu0izExD92tijGon3MTWCNdYB4
         ntew==
X-Gm-Message-State: AOAM532ul42MKjAmvVyfuU0uS2OuPKmpTsx4m8OlKD1RsEoFBIoFTeqJ
        /RUa/kvaHx2EpX+GGunEsaxCTBFY14IfX7OFK0RDc7N1M8pN58oM
X-Google-Smtp-Source: ABdhPJwbrrGS9bqSbKtVkoDalVjTu3+jzIs//7ofBI1BPmNlQ6k9MBhRntDFyOnUW0vkvIfkDYAenwI/lVbUaz/Vqu8=
X-Received: by 2002:a17:906:aecd:: with SMTP id me13mr1459415ejb.324.1618315926291;
 Tue, 13 Apr 2021 05:12:06 -0700 (PDT)
MIME-Version: 1.0
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 13 Apr 2021 14:11:54 +0200
Message-ID: <CADYN=9+JDiZarjWUZKT9P27UgDYfR4afGbH9CMd3jtxQi=8ZyA@mail.gmail.com>
Subject: backport patches to linux-5.4.y
To:     linux-stable <stable@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        acme@redhat.com, ravi.bangoria@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Can these patches be backported to linux-5.4.y, I've tried to build
perf on arm and it failed without these patches.
fc8c0a992233 ("perf tools: Use %define api.pure full instead of %pure-parser")
20befbb10803 ("perf tools: Use %zd for size_t printf formats on 32-bit")
77d02bd00cea ("perf map: Tighten snprintf() string precision to pass
gcc check on some 32-bit arches")



Commit fc8c0a992233 ("perf tools: Use %define api.pure full instead of
%pure-parser") fixes:

util/parse-events.y:1.1-12: warning: deprecated directive:
'%pure-parser', use '%define api.pure' [-Wdeprecated]
    1 | %pure-parser
      | ^~~~~~~~~~~~
      | %define api.pure

Commit 20befbb10803 ("perf tools: Use %zd for size_t printf formats on
32-bit") fixes:

In file included from util/session.c:17:
util/session.c: In function 'perf_session__process_compressed_event':
util/session.c:91:11: error: format '%ld' expects argument of type
'long int', but argument 4 has type 'size_t' {aka 'unsigned int'}
[-Werror=format=]
   91 |  pr_debug("decomp (B): %ld to %ld\n", src_size, decomp_size);
      |           ^~~~~~~~~~~~~~~~~~~~~~~~~~
util/debug.h:16:21: note: in definition of macro 'pr_fmt'
   16 | #define pr_fmt(fmt) fmt
      |                     ^~~
util/session.c:91:2: note: in expansion of macro 'pr_debug'
   91 |  pr_debug("decomp (B): %ld to %ld\n", src_size, decomp_size);
      |  ^~~~~~~~

Commit 77d02bd00cea ("perf map: Tighten snprintf() string precision to
pass gcc check on some 32-bit arches") fixes:

util/map.c: In function 'map__new':
util/map.c:125:5: error: '%s' directive output may be truncated
writing between 1 and 2147483645 bytes into a region of size 4096
[-Werror=format-truncation=]
  125 |    "%s/platforms/%s/arch-%s/usr/lib/%s",
      |     ^~
In file included from /usr/arm-linux-gnueabihf/include/stdio.h:867,
                 from util/symbol.h:11,
                 from util/map.c:2:
/usr/arm-linux-gnueabihf/include/bits/stdio2.h:67:10: note:
'__builtin___snprintf_chk' output 32 or more bytes (assuming
4294967321) into a destination of size 4096
   67 |   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   68 |        __bos (__s), __fmt, __va_arg_pack ());
      |        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Cheers,
Anders
