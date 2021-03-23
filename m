Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89DB1346B34
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 22:38:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233663AbhCWViJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 17:38:09 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:47193 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbhCWVhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 17:37:51 -0400
Received: from relay13.mail.gandi.net (unknown [217.70.178.233])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 741FF3A97AB;
        Tue, 23 Mar 2021 21:20:01 +0000 (UTC)
Received: from localhost (lfbn-lyo-1-1676-55.w90-65.abo.wanadoo.fr [90.65.108.55])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay13.mail.gandi.net (Postfix) with ESMTPSA id CA9608000B;
        Tue, 23 Mar 2021 21:19:39 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org,
        Conor Culhane <conor.culhane@silvaco.com>,
        linux-i3c@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: i3c: Fix silvaco,i3c-master-v1 compatible string
Date:   Tue, 23 Mar 2021 22:19:39 +0100
Message-Id: <161653435327.363771.4551073888440261165.b4-ty@bootlin.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210311234056.1588751-1-robh@kernel.org>
References: <20210311234056.1588751-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2021 16:40:56 -0700, Rob Herring wrote:
> The example for the Silvaco I3C master doesn't match the schema's
> compatible string. Fix it.

Applied, thanks!

[1/1] dt-bindings: i3c: Fix silvaco,i3c-master-v1 compatible string
      commit: e43d5c7c3c3459b428431754672052503c5db9c8

Best regards,
-- 
Alexandre Belloni <alexandre.belloni@bootlin.com>
