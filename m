Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBD424410F1
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 22:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbhJaVNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 17:13:36 -0400
Received: from ip-16.mailobj.net ([213.182.54.16]:37060 "EHLO msg-6.mailo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229946AbhJaVNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 17:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1635714614; bh=akLm6mpjT90D/3YVJPqQM1JvsIyznVLKAosT+ZJ2Bno=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
         MIME-Version:Content-Transfer-Encoding;
        b=UrsGd5fOdGCQELdy90i+J9MMHqBdO8MB+WbEwvni9iXsWue0iSOtFVF96E0G1CbTP
         i1ADq6bwiijnlgp1kHdwiszCnFciGXnJsnkxX6g4vpElMyS4EcUf8zlcAnEmlSBS5s
         qFQ0J52+u/9ukhzG8PLrKNAMHOWSXIdsq3H/DrK0=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Sun, 31 Oct 2021 22:10:14 +0100 (CET)
X-EA-Auth: 1WIvScNvxc5QIVSNyo9KlBZg6hqEvdYfHkhllM9TSu8uqh1lDXo64Vp8jZN18LegR6aq73WPmW96r/9n7bU1IEVpxxHKVDjHA1pqUjqg7/U=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     stephan@gerhold.net, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Vincent Knecht <vincent.knecht@mailoo.org>
Subject: [PATCH 0/2] Add tfa9897 rcv-gpios support
Date:   Sun, 31 Oct 2021 22:09:54 +0100
Message-Id: <20211031210956.812101-1-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the continuation of a previous series [1] where
- patch 1/4 is removed in favor of using pin switch
  This will be posted independently of tfa989x support,
  since it mainly require changes to sound/soc/qcom/common.c
  and device DTS.
- patch 2/4 is already merged
so here are reworked patch 3/4 (bindings fixed and example added)
and patch 4/4 unchanged.

[1] https://patchwork.kernel.org/project/alsa-devel/cover/20211024085840.1536438-1-vincent.knecht@mailoo.org/

Vincent Knecht (2):
  ASoC: dt-bindings: nxp, tfa989x: Add rcv-gpios property for tfa9897
  ASoC: codecs: tfa989x: Add support for tfa9897 optional rcv-gpios

 .../bindings/sound/nxp,tfa989x.yaml           | 41 +++++++++++++++++++
 sound/soc/codecs/tfa989x.c                    | 20 ++++++++-
 2 files changed, 60 insertions(+), 1 deletion(-)

-- 
2.31.1



