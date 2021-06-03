Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A1F399A7C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 08:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhFCGN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 02:13:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:35764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229635AbhFCGNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 02:13:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C925261026;
        Thu,  3 Jun 2021 06:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622700700;
        bh=Q73hleFszlpPr7Oa7eVZiC4Dnz966gpJ5+K8H/8Os2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ArxxWSnO+TdzZmqJcyZv1mF6rXgBUNVRd6lQry26UdFoVTjnfVhJbNS3J01UZPR1E
         iYpROH+9QjrVVn4sw9LmgBE1YH1gmv8iq8BQaFcZiXd+9ST92XFt4qhAT8gpYyYu1A
         pENYiOfHfrvrosOFt3SUc3KN2UmkgPEYYVS0V2a4WfLbNw4gTxmhMrKBmMBRqSf0Yw
         6vUwS/A4wk64OvAkbUIo+ZlxTTC6ulUvNZAi8bwrIesqGB5hfZidbMxa7T4xK9qL8j
         FFC3fuIbMoxATN1XtGBP98Q1bubMIgXj3A8xOgfAPKmgHFS8rgbeGcz1cXdNSdX92H
         iGgAgUPTnTrjA==
Date:   Thu, 3 Jun 2021 11:41:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Konstantin Porotchkin <kostap@marvell.com>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] MAINTAINERS: update
 marvell,armada-3700-utmi-phy.yaml reference
Message-ID: <YLhymAdxSJrYfcnt@vkoul-mobl>
References: <cover.1622648507.git.mchehab+huawei@kernel.org>
 <9342a88ed44726a1cc405470c834d746d4d0524c.1622648507.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9342a88ed44726a1cc405470c834d746d4d0524c.1622648507.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-06-21, 17:43, Mauro Carvalho Chehab wrote:
> Changeset 6569d8386388 ("dt-bindings: phy: convert phy-mvebu-utmi to YAML schema")
> renamed: Documentation/devicetree/bindings/phy/phy-mvebu-utmi.txt
> to: Documentation/devicetree/bindings/phy/marvell,armada-3700-utmi-phy.yaml.
> 
> Update its cross-reference accordingly.

Applied, thanks

-- 
~Vinod
