Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8F140978C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 17:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245023AbhIMPht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 11:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241525AbhIMPhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 11:37:43 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE05C12D8FD;
        Mon, 13 Sep 2021 07:49:07 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id b5-20020a4ac285000000b0029038344c3dso3470230ooq.8;
        Mon, 13 Sep 2021 07:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q4jWiRn0EuHca/77FmGUXr9JidHyCu6zqvvX4/H4GKc=;
        b=Oz4McVU7NUlBp5WhDmQCi6Kh7HTc5Rl7MA17CpdMCeyAedY8PqerQ5ZMsO/oZQTcsq
         ebPiBeex7sZpeptcYzJqjjwz6CrqjN1Or0saJf+j4AYRMZlE99FzKEif5S14Ehj9nh3t
         O4MooFl+HRGB5LkqXqsakryHdEoj3qZoK7HykK67I0OTTEkZfLpif0em+R9t1LR5KSKI
         3Y0hx5mRM2GJ6yxywzA5zISi0maQgwJZZr3lyAxVL+1TEq905c6zvmoWmm7RffqxhZwJ
         wpnn6Js5pBeJR40DrhMSD3euygHa1KIGBT6y6iv+JIIexebTrbLrolzv8kjSKR+p/wCa
         KWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=q4jWiRn0EuHca/77FmGUXr9JidHyCu6zqvvX4/H4GKc=;
        b=6QXO7C1vYhJNFX0ArF/wqQZNqk2YhSmnTbvQINmx66P4oKVIapFE1LJFQsZaWAaDrX
         aa1kA17R8k7lfHv+4kCyvAzMi0W0d6oXi9XJeHn7rkwFAt9qVXILqc9ku5UdBvq+/uhz
         GY4Db/oqG4fM3Vy99oHSz7KwJmf+nRHpcyl3OGZ1L6hyEI+zNmBXkUs669Z5Ay0MBDdH
         ZqNM5uMGOMsNDtDbXUI56iiCJYRTzrkBlnQAbzPYoGOeGQ0Y7CuvteFU+4SG791QbPNM
         fR3kYtPQBDoKW1Ksm+53WNZlH9Q9AI3RgNO7vUHiXE4uBuNwEOOULQvA0ogsCtcVMNqA
         c0hg==
X-Gm-Message-State: AOAM533h9tw4ZEeh1SyqATGrVuO/wk4sS6CkWyZ4fOxLbtERY6liyuNF
        9e0efmxHRthche9cKRFYjwZatMQBIRw=
X-Google-Smtp-Source: ABdhPJzBzQ6oFo9K/fhw61EZCPISGz1/7xiPnY6usVy1xPG080I7ZprWhAO98fijOUj6RgBYRpPmbw==
X-Received: by 2002:a4a:a8c9:: with SMTP id r9mr9488940oom.49.1631544546943;
        Mon, 13 Sep 2021 07:49:06 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b2sm1893686ook.46.2021.09.13.07.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 07:49:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 13 Sep 2021 07:49:05 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Jie Deng <jie.deng@intel.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3 5/5] virtio: Bind virtio device to device-tree node
Message-ID: <20210913144905.GA1267554@roeck-us.net>
References: <cover.1627273794.git.viresh.kumar@linaro.org>
 <454a58f998b0d16847d72a97b32192829fab2c8c.1627273794.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454a58f998b0d16847d72a97b32192829fab2c8c.1627273794.git.viresh.kumar@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2021 at 10:21:45AM +0530, Viresh Kumar wrote:
> Bind the virtio devices with their of_node. This will help users of the
> virtio devices to mention their dependencies on the device in the DT
> itself. Like GPIO pin users can use the phandle of the device node, or
> the node may contain more subnodes to add i2c or spi eeproms and other
> users.
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

This patch causes a boot failure on sparc64: The virtio device no longer
instantiates. Reverting this patch fixes the problem. Bisect log attached.

Guenter

---
# bad: [6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f] Linux 5.15-rc1
# good: [926de8c4326c14fcf35f1de142019043597a4fac] Merge tag 'acpi-5.15-rc1-3' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
git bisect start 'HEAD' '926de8c4326c'
# good: [8177a5c96229ff24da1e362789e359b68b4f34f5] Merge tag 'libata-5.15-2021-09-11' of git://git.kernel.dk/linux-block
git bisect good 8177a5c96229ff24da1e362789e359b68b4f34f5
# bad: [78e709522d2c012cb0daad2e668506637bffb7c2] Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost
git bisect bad 78e709522d2c012cb0daad2e668506637bffb7c2
# bad: [7bc7f61897b66bef78bb5952e3d1e9f3aaf9ccca] Documentation: Add documentation for VDUSE
git bisect bad 7bc7f61897b66bef78bb5952e3d1e9f3aaf9ccca
# bad: [41116599a0731f4cd451e9d191d879ab45e31945] virtio/vsock: add 'VIRTIO_VSOCK_SEQ_EOR' bit.
git bisect bad 41116599a0731f4cd451e9d191d879ab45e31945
# good: [5262912ef3cfc5e518892c3d67fb36412cb813e2] vdpa/mlx5: Add support for control VQ and MAC setting
git bisect good 5262912ef3cfc5e518892c3d67fb36412cb813e2
# good: [7f815fce08d563006e43d1b7d2f9a0a4f3b832f3] dt-bindings: i2c: Add bindings for i2c-virtio
git bisect good 7f815fce08d563006e43d1b7d2f9a0a4f3b832f3
# good: [d5a8680dfab0547a4ecd708b1fe9de48598a6757] uapi: virtio_ids: Sync ids with specification
git bisect good d5a8680dfab0547a4ecd708b1fe9de48598a6757
# bad: [9af8f1061646e8e22b66413bedf7b3e2ab3d69e5] virtio/vsock: rename 'EOR' to 'EOM' bit.
git bisect bad 9af8f1061646e8e22b66413bedf7b3e2ab3d69e5
# bad: [694a1116b405d887c893525a6766b390989c8606] virtio: Bind virtio device to device-tree node
git bisect bad 694a1116b405d887c893525a6766b390989c8606
# first bad commit: [694a1116b405d887c893525a6766b390989c8606] virtio: Bind virtio device to device-tree node
