Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C0737723E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 15:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhEHN6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 09:58:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:48168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229494AbhEHN6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 09:58:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 29E4661350;
        Sat,  8 May 2021 13:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620482268;
        bh=2Kkp/aLUt4Isw8H/gS1XCwNF7zoDOXgpMaf4o4mDwJE=;
        h=Date:From:To:Cc:Subject:From;
        b=Upim/1WLOVXfhd8ncqUgNvlGquRMSX9hpaFROtBVfCjEUkTk9zZpWwWNEsfPvANwr
         EoNgdFLqjqV3QSJ8faKHrfGOqPlaujVdQ5I000d67GOvXWZGpSE26lfxU9jT37cBiB
         riI242mJY1fFIVvb46Wan4bET/qZAM3YlcjE02UJ/yqvfDwHN05/5QxD0ZMCU8lmX+
         U7X2G4vO1T4aPGgYDKX2u3g+O7TwQ1mp4c3Ky2gI2ur9JQCTeVC1ht2mxhudGlT1lg
         KLiD6i2qmwRXsvucezSxKn1oCKHOMAbIIxyA+QwJycvoKDML7TgKO7YaQpNRGSS6h6
         XtewKpNf9lPGQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6E9D84034C; Sat,  8 May 2021 10:57:45 -0300 (-03)
Date:   Sat, 8 May 2021 10:57:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: BUILD_BPF_SKEL error message
Message-ID: <YJaY2auB5advkzrg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I switched to Fedora 34 Silverblue, and while installing the needed
packages to build perf, using BUILD_BPF_SKEL=1 I noticed this:

Makefile.config:637: *** Error: clang too old. Please install recent clang.  Stop.

The problem is not that clang is too old, its that it is not installed
:-)

Perhaps a slight improvement to state that, something like:

Makefile.config:637: *** Error: clang too old/not installed. Please install recent clang to build with BPF_SKEL.  Stop.

As for a moment I thought clang now was _required_ to build perf, which
isn't the case, it was just me using an alias to build perf:

alias m='make -k BUILD_BPF_SKEL=1 PYTHON=python3 O=/tmp/build/perf -C tools/perf install-bin && perf test python'

Regards,

- Arnaldo
