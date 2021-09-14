Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C9840A699
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 08:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240040AbhINGSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 02:18:10 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:43921 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239600AbhINGSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 02:18:09 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20210914061651euoutp024bbb90b625dfec1a790adfdcc1bed542~km7_DA8eN0904509045euoutp02W
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 06:16:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20210914061651euoutp024bbb90b625dfec1a790adfdcc1bed542~km7_DA8eN0904509045euoutp02W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1631600211;
        bh=sJ896bsTZuWbJZQuipKgY7jqTRqWY4opH73RzQpVHts=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=cngnM9XRXtEMimi5PWNF3TAOJr8g+E/QT/pd3rhGggEgAvnHVzOko3yUu4J+MdsbI
         kZC4RhOKdfQBrEIewq2imt437XG31wjX3WfZQ5APOh4/QbhMhBEEdvJxkd5Ohh8yvh
         KrFxeKMoj95EAT9JfCb7LImsXQtXiZzTY5ivkpVA=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210914061651eucas1p130b23ce3f853fb0f75d3099eaa4e0489~km79y8uZd1713217132eucas1p1C;
        Tue, 14 Sep 2021 06:16:51 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 56.E4.45756.35E30416; Tue, 14
        Sep 2021 07:16:51 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210914061650eucas1p2d432b97038c76ee9778ee7678cbfd841~km79FdOLS3083730837eucas1p2G;
        Tue, 14 Sep 2021 06:16:50 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210914061650eusmtrp1a28088e7d11743320886713aa17ce89d~km79EuVjP1049310493eusmtrp1w;
        Tue, 14 Sep 2021 06:16:50 +0000 (GMT)
X-AuditID: cbfec7f2-7d5ff7000002b2bc-2f-61403e53fab9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D5.EF.31287.25E30416; Tue, 14
        Sep 2021 07:16:50 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210914061650eusmtip206166440f8aee732d2482ce16a42807d~km78aB3wy2697426974eusmtip2Y;
        Tue, 14 Sep 2021 06:16:50 +0000 (GMT)
Subject: Re: [PATCH v1 1/5] driver core: fw_devlink: Improve handling of
 cyclic dependencies
To:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <7756112c-0378-f48b-ef5a-aafc994dc662@samsung.com>
Date:   Tue, 14 Sep 2021 08:16:50 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210914043928.4066136-2-saravanak@google.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAKsWRmVeSWpSXmKPExsWy7djP87rBdg6JBp2zZCzO3z3EbPHs1l4m
        i+bF69kszvzWtdixXcTi8q45bBYbNn9nspj7ZSqzReveI+wWXYf+sjlweWzbvY3VY+esu+we
        CzaVemxa1cnmcefaHjaPQ4c7GD32z13D7rFzx2cmj8+b5AI4o7hsUlJzMstSi/TtErgy/kw+
        zlTwX7Li+sQJjA2Mf0W6GDk5JARMJJrvLmTpYuTiEBJYwShxb99URgjnC6PEzznHmUCqhAQ+
        M0rMWK4O03Fj0lpmiKLljBITLnexQTgfGSUu3F/CClIlLBAncW/9B7C5IgJtjBIP9/0Ec5gF
        vjJKfLi4nhGkik3AUKLrLUg7JwevgJ3E0u3fWEBsFgFViT/bbrKD2KICyRLT/jYxQ9QISpyc
        +QSshlPARuLn96tgNcwC8hLb385hhrDFJW49mc8EskxCoJ9TYvv6tUwQh7tIvL41D8oWlnh1
        fAs7hC0jcXpyDwtEQzPQqefWskM4PYwSl5tmMEJUWUvcOfcL6FQOoBWaEut36UOEHSXOrJnI
        BBKWEOCTuPFWEOIIPolJ26YzQ4R5JTrahCCq1SRmHV8Ht/bghUvMExiVZiF5bRaSd2YheWcW
        wt4FjCyrGMVTS4tz01OLDfNSy/WKE3OLS/PS9ZLzczcxAhPZ6X/HP+1gnPvqo94hRiYOxkOM
        EhzMSiK8297YJgrxpiRWVqUW5ccXleakFh9ilOZgURLnXTV7TbyQQHpiSWp2ampBahFMlomD
        U6qBSfl7YOfnbo71zz5wsUzUZd5r8y6fwYXBMIY9YDtf0CrFssx1f3NPvNWaJZ/0K7c3LXmV
        Qynv2f8ZSrl6nTergq9/3r1J3r56V9UK5t50MZbqnJ3OhyYe8Q3LWL/RvGf1QwnXJd8KXtht
        u9+z4cnp8lIWlorfC6ZubTzsf6J19bO6r+xTn6ild5dcF/n0K3fC/85/jhMj5s0562fXvt37
        9aU1bme+pxn8/74mTM7SKTvzU31tcPANFaYpfhkePvJZ266nslgv22q85Irp07lV0+b9t3/5
        29rn2bvJ/UIKLfGiEuVm53R1V3rE1M/TOptv819ppdPW7llC/1yWesXq5UhML/k74dEFm8Jv
        nOwZSizFGYmGWsxFxYkA4+cjItMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsVy+t/xe7pBdg6JBnPmalmcv3uI2eLZrb1M
        Fs2L17NZnPmta7Fju4jF5V1z2Cw2bP7OZDH3y1Rmi9a9R9gtug79ZXPg8ti2exurx85Zd9k9
        Fmwq9di0qpPN4861PWwehw53MHrsn7uG3WPnjs9MHp83yQVwRunZFOWXlqQqZOQXl9gqRRta
        GOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehl/Jl8nKngv2TF9YkTGBsY/4p0MXJy
        SAiYSNyYtJa5i5GLQ0hgKaPEzZ5HTBAJGYmT0xpYIWxhiT/Xutggit4zSry+e5cRJCEsECdx
        b/0HFpCEiEAHo8S3q9fBqpgFvjJK3O5ZzQLRcpBRYu7PeSwgLWwChhJdb0FmcXLwCthJLN3+
        DSzOIqAq8WfbTXYQW1QgWeLt6+9MEDWCEidnPgGr4RSwkfj5/SpYDbOAmcS8zQ+ZIWx5ie1v
        50DZ4hK3nsxnmsAoNAtJ+ywkLbOQtMxC0rKAkWUVo0hqaXFuem6xoV5xYm5xaV66XnJ+7iZG
        YOxuO/Zz8w7Gea8+6h1iZOJgPMQowcGsJMK77Y1tohBvSmJlVWpRfnxRaU5q8SFGU6B/JjJL
        iSbnA5NHXkm8oZmBqaGJmaWBqaWZsZI479a5a+KFBNITS1KzU1MLUotg+pg4OKUamCYuFZn7
        um2q5nMW/5ork91Ve42mOX61FJh8NChrD/v63bsYlq4pvVy7Qq8uPPmr6bdeibwVzm9N4hJE
        f8+4s6+27EXc7y/XHn+ZoT/P8Lqgol/r5dmtP7fYP0p+NuWKxo1Drww0nolOv3bQunyD34uN
        Xo2q+e9uL9JM3SXckOJesMZsnkXmks6z/Nv7DOcZcGp/WuD4Mv6i0fbrDW0fAvgS2q2rxR6y
        bVLxeRX75XUD3+LnmQmTaoW+pupqOkc0Wh3PVX+17WvV1tfbq/UamG4KCDnwrEydt9Sp4VxK
        Y9tU/SW9k/6m1HI77zl04H6Ck9+0Gu+KEwVnPhaU37cvqoyqlHQzW2096WhCfMnNbUosxRmJ
        hlrMRcWJAAeCf89mAwAA
X-CMS-MailID: 20210914061650eucas1p2d432b97038c76ee9778ee7678cbfd841
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210914043943eucas1p134f89c3399fb2bb6a5f24ea5b6119188
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210914043943eucas1p134f89c3399fb2bb6a5f24ea5b6119188
References: <20210914043928.4066136-1-saravanak@google.com>
        <CGME20210914043943eucas1p134f89c3399fb2bb6a5f24ea5b6119188@eucas1p1.samsung.com>
        <20210914043928.4066136-2-saravanak@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.09.2021 06:39, Saravana Kannan wrote:
> When we have a dependency of the form:
>
> Device-A -> Device-C
> 	Device-B
>
> Device-C -> Device-B
>
> Where,
> * Indentation denotes "child of" parent in previous line.
> * X -> Y denotes X is consumer of Y based on firmware (Eg: DT).
>
> We have cyclic dependency: device-A -> device-C -> device-B -> device-A
>
> fw_devlink current treats device-C -> device-B dependency as an invalid
> dependency and doesn't enforce it but leaves the rest of the
> dependencies as is.
>
> While the current behavior is necessary, it is not sufficient if the
> false dependency in this example is actually device-A -> device-C. When
> this is the case, device-C will correctly probe defer waiting for
> device-B to be added, but device-A will be incorrectly probe deferred by
> fw_devlink waiting on device-C to probe successfully. Due to this, none
> of the devices in the cycle will end up probing.
>
> To fix this, we need to go relax all the dependencies in the cycle like
> we already do in the other instances where fw_devlink detects cycles.
> A real world example of this was reported[1] and analyzed[2].
>
> [1] - https://lore.kernel.org/lkml/0a2c4106-7f48-2bb5-048e-8c001a7c3fda@samsung.com/
> [2] - https://lore.kernel.org/lkml/CAGETcx8peaew90SWiux=TyvuGgvTQOmO4BFALz7aj0Za5QdNFQ@mail.gmail.com/
> Fixes: f9aa460672c9 ("driver core: Refactor fw_devlink feature")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>   drivers/base/core.c | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index e65dd803a453..316df6027093 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1772,14 +1772,21 @@ static int fw_devlink_create_devlink(struct device *con,
>   	 * be broken by applying logic. Check for these types of cycles and
>   	 * break them so that devices in the cycle probe properly.
>   	 *
> -	 * If the supplier's parent is dependent on the consumer, then
> -	 * the consumer-supplier dependency is a false dependency. So,
> -	 * treat it as an invalid link.
> +	 * If the supplier's parent is dependent on the consumer, then the
> +	 * consumer and supplier have a cyclic dependency. Since fw_devlink
> +	 * can't tell which of the inferred dependencies are incorrect, don't
> +	 * enforce probe ordering between any of the devices in this cyclic
> +	 * dependency. Do this by relaxing all the fw_devlink device links in
> +	 * this cycle and by treating the fwnode link between the consumer and
> +	 * the supplier as an invalid dependency.
>   	 */
>   	sup_dev = fwnode_get_next_parent_dev(sup_handle);
>   	if (sup_dev && device_is_dependent(con, sup_dev)) {
> -		dev_dbg(con, "Not linking to %pfwP - False link\n",
> -			sup_handle);
> +		dev_info(con, "Fixing up cyclic dependency with %pfwP (%s)\n",
> +			 sup_handle, dev_name(sup_dev));
> +		device_links_write_lock();
> +		fw_devlink_relax_cycle(con, sup_dev);
> +		device_links_write_unlock();
>   		ret = -EINVAL;
>   	} else {
>   		/*

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

