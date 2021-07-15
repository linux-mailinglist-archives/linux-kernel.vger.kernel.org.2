Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3EF3C959F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 03:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbhGOBg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 21:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235370AbhGOBgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 21:36:54 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA826C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 18:34:01 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id u8-20020a0562141c08b02902e82df307f0so2979882qvc.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 18:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=l9ulLD/fU9W0OzwZvZuuX6b1DWiP15Rr9ZcqPkR8f8k=;
        b=CkCzHjKN+XzIPI2Z5zYy3Yi3XPmd2TIinrVvFVKDdgrl54PJA5sH0dgxtyPE2HP9cI
         vGdd3rUu9rt/3q6Ruq9Ctp4SQ8IKLu6SJUbIjTWtk/+x4oI7ZtpIVyUsW8uJS6MYyaqg
         BXNifY1jn40WqPMglg65h+DZMQvLMfug1LaKOeF82/wsnF/odLT1t0LbwqYJxU95K2ax
         XjXH6rv+s/EnPO6Yhc30BVHg6pkqrJpo6utrc9R8atbw9MjLGff2NsfOsFaIsLmbFDQu
         KdPoWYqhJhaTjf44ssIjf1PfJk3ubGwkzKiJEMyM3J6475CYoTeenCUVFBQsow1c7sPV
         fcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l9ulLD/fU9W0OzwZvZuuX6b1DWiP15Rr9ZcqPkR8f8k=;
        b=NijgjSV9wwbeq9eJTMAtank75+LKGTu47dUrucncs5I7j8MwhdyvPrKYUqmfpEIifi
         tNOcG6n+a63utWSmYM5Q0heWlF05nERj1DDJNZN7mUsK4pvQeAdeVGiC2tmTcGUKs0ih
         hoEBfz3hSC+hfGV3TZmigVRsw5Jx+R1D2ogLM4SoklwFdB9L2Yf5DDB0lnPaSQpJv/1n
         LvoQZKZgqtx6YzsFbweF7H+FKddIyv4dPncJe1hfHGC27HtaLw5F1XHBc/SVs+zoKK+2
         j3yE/l6nbUGSBpcnsQYotW7dwoAH+Mo/ewn+Qf6CvwD0bJSz1J4o76CcepBhMZWoBei+
         iRFQ==
X-Gm-Message-State: AOAM531xxFnPJxaGBgjearHbJ2hMVdPXC0HVqzhZhZAo0p3nSF711NoD
        zZxraozfokmpU+QIWh/jtMPJoTI9S9Nx
X-Google-Smtp-Source: ABdhPJwkeYsMicvviGQ328kdTa+3vamfieBa/crfDN2NpM25ZiGM1zK9Rz0mMWhNhBeIMraKrLaQFf3rF7vy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:c0a3:e3b0:6b14:de32])
 (user=irogers job=sendgmr) by 2002:a05:6214:d6d:: with SMTP id
 13mr1049593qvs.3.1626312840822; Wed, 14 Jul 2021 18:34:00 -0700 (PDT)
Date:   Wed, 14 Jul 2021 18:33:39 -0700
In-Reply-To: <20210715013343.2286699-1-irogers@google.com>
Message-Id: <20210715013343.2286699-4-irogers@google.com>
Mime-Version: 1.0
References: <20210715013343.2286699-1-irogers@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [PATCH 3/7] perf doc: Remove references to user-manual
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf doesn't have a user-manual.txt, but git does and this explains why
there are references here. Having these references breaks 'make info' as
user-manual.info can't be created given the missing dependency. Remove
all references to user-manual so that 'make info' can succeed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/Makefile | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/tools/perf/Documentation/Makefile b/tools/perf/Documentation/Makefile
index 859ec1496716..03300c151858 100644
--- a/tools/perf/Documentation/Makefile
+++ b/tools/perf/Documentation/Makefile
@@ -186,8 +186,6 @@ man7: $(DOC_MAN7)
 
 info: $(OUTPUT)perf.info $(OUTPUT)perfman.info
 
-pdf: $(OUTPUT)user-manual.pdf
-
 install: install-man
 
 check-man-tools:
@@ -225,11 +223,6 @@ install-info: info
 	  echo "No directory found in $(DESTDIR)$(infodir)" >&2 ; \
 	fi
 
-install-pdf: pdf
-	$(call QUIET_INSTALL, Documentation-pdf) \
-		$(INSTALL) -d -m 755 $(DESTDIR)$(pdfdir); \
-		$(INSTALL) -m 644 $(OUTPUT)user-manual.pdf $(DESTDIR)$(pdfdir)
-
 #install-html: html
 #	'$(SHELL_PATH_SQ)' ./install-webdoc.sh $(DESTDIR)$(htmldir)
 
@@ -304,24 +297,6 @@ $(OUTPUT)%.xml : %.txt
 XSLT = docbook.xsl
 XSLTOPTS = --xinclude --stringparam html.stylesheet docbook-xsl.css
 
-$(OUTPUT)user-manual.html: $(OUTPUT)user-manual.xml
-	$(QUIET_XSLTPROC)xsltproc $(XSLTOPTS) -o $@ $(XSLT) $<
-
-$(OUTPUT)perf.info: $(OUTPUT)user-manual.texi
-	$(QUIET_MAKEINFO)$(MAKEINFO) --no-split -o $@ $(OUTPUT)user-manual.texi
-
-$(OUTPUT)user-manual.texi: $(OUTPUT)user-manual.xml
-	$(QUIET_DB2TEXI)$(RM) $@+ $@ && \
-	$(DOCBOOK2X_TEXI) $(OUTPUT)user-manual.xml --encoding=UTF-8 --to-stdout >$@++ && \
-	$(PERL_PATH) fix-texi.perl <$@++ >$@+ && \
-	rm $@++ && \
-	mv $@+ $@
-
-$(OUTPUT)user-manual.pdf: $(OUTPUT)user-manual.xml
-	$(QUIET_DBLATEX)$(RM) $@+ $@ && \
-	$(DBLATEX) -o $@+ -p /etc/asciidoc/dblatex/asciidoc-dblatex.xsl -s /etc/asciidoc/dblatex/asciidoc-dblatex.sty $< && \
-	mv $@+ $@
-
 $(OUTPUT)perfman.texi: $(MAN_XML) cat-texi.perl
 	$(QUIET_DB2TEXI)$(RM) $@+ $@ && \
 	($(foreach xml,$(MAN_XML),$(DOCBOOK2X_TEXI) --encoding=UTF-8 \
-- 
2.32.0.402.g57bb445576-goog

