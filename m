Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC313D2360
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 14:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhGVLxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 07:53:38 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21384 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbhGVLxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 07:53:36 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1626957249; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=cF3NV3KAt29Sf/rMRYrYN9ooiXFU1Qbo7JUHgJN/GvabycyU5bclL3r+qCJyJTdt+gFl9AHMfsD7ymMusAXaNcFnn6truGqIJ5JSNn7nAgpT/aof9VzN6O3Nu+rsKxXwq1g2RKt6uF3fr20asZ20wOzOpv3pwZLT+Yi8XAt3fvc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1626957249; h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=+xjmJsGh9HKYxZlwI9c52nF61hk9sjd0HiYWIidswWo=; 
        b=jUj7qjYgHdjH1m3IJhKu+23Gb31bx1cdoRx4RAoY3GzCbpPTYUPwYaWTvyx4MEv5yh4cGu+g2npFQbrfTydCNQEspHywGwx3x+A8qgqGVTMq2d931u+GjQIVvu00ft+T9hMl5LsakDt7uXwVzKQnNZC9o9bTcI4E5sjTIrysdS8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1626957249;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        bh=+xjmJsGh9HKYxZlwI9c52nF61hk9sjd0HiYWIidswWo=;
        b=dz016In0RTp7PJg4W0TGYUBYuTNtaTt8TY4v+GSkHnhq5A8JGuCX0el6UcueiXjY
        wk2NvZfsRihFoq/77i7Ii+bgOXyc1pBztUrmi8CDyMuHlcXxeoxrndGrmVJmsJdyXsR
        +OKXQoXSqeJsw4G+6ubs4QViRNOBAgH5AO0nLpxg=
Received: from anirudhrb.com (49.207.63.174 [49.207.63.174]) by mx.zohomail.com
        with SMTPS id 162695724585718.164515886124036; Thu, 22 Jul 2021 05:34:05 -0700 (PDT)
Date:   Thu, 22 Jul 2021 18:03:59 +0530
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v5 1/2] firmware_loader: use -ETIMEDOUT instead of
 -EAGAIN in fw_load_sysfs_fallback
Message-ID: <YPlltzyc+hgq51u3@anirudhrb.com>
References: <20210721190014.2313-1-mail@anirudhrb.com>
 <20210721190014.2313-2-mail@anirudhrb.com>
 <CAB=NE6UbB0VT+CZ0aD140LSj6DvRs==_GMxJ=isj30idnStbfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB=NE6UbB0VT+CZ0aD140LSj6DvRs==_GMxJ=isj30idnStbfQ@mail.gmail.com>
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 12:14:37PM -0700, Luis Chamberlain wrote:
> But the patch still keeps it, please remove the -EAGAIN setting completely.

Oops, my bad! Sent a new version.

	- Anirudh.
