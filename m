Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D5833E8D3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 06:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbhCQFNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 01:13:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52518 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhCQFNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 01:13:21 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12H55atA193847;
        Wed, 17 Mar 2021 05:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=e3AsKex4U5uvsezbmuwcKMcjdD3MxBxudYNAoxz4it8=;
 b=L5IRm6XgO1B5jamU4YRoaG38ySXsSU6XP3yJvi7RYuYW8amuXYucxU5amtV3I/UVnoH4
 3jmM9ifq+SzpYW4z7ZzQNWC0YWGiAWveKcKj9+9nEJo3IWronknq2H2fm4WjatsbZMp6
 PQucMlXFPf3LnaxaWnSUHtesbJL9xhnUy9CyH0tryFUhvE/5IZ9V5nwOHWUfNrurefpC
 kADQd9HN1T2A4MXFG65BnZFOzLfxueRLwnvWco8/sb3WHPhUTOXtS5BdD7lKux/YMzL0
 1N+HfWb3scXhmwBKuaO7uy3hbIwmtnkPW08Ojix3UiDTKIXUtuVHCAXvOo8egcShiHJZ 1w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37a4ekqra0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Mar 2021 05:12:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12H5BNHZ158643;
        Wed, 17 Mar 2021 05:12:55 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 37a4etwady-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Mar 2021 05:12:55 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 12H5CoQb013036;
        Wed, 17 Mar 2021 05:12:50 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 16 Mar 2021 22:12:49 -0700
Date:   Wed, 17 Mar 2021 08:12:40 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        =?iso-8859-1?Q?V=E1clav_Kubern=E1t?= <kubernat@cesnet.cz>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        =?iso-8859-1?Q?V=E1clav_Kubern=E1t?= <kubernat@cesnet.cz>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] hwmon: (max31790) Rework to use regmap
Message-ID: <20210317051239.GW2087@kadam>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ImRTeRIkqB4CPXi5"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210316175503.1003051-1-kubernat@cesnet.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9925 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103170040
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9925 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103170039
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ImRTeRIkqB4CPXi5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi "Václav,

url:    https://github.com/0day-ci/linux/commits/V-clav-Kubern-t/hwmon-max31790-Rework-to-use-regmap/20210317-015931
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
config: x86_64-randconfig-m001-20210316 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/hwmon/max31790.c:263 max31790_fan_is_visible() warn: impossible condition '(fan_config < 0) => (0-255 < 0)'
drivers/hwmon/max31790.c:337 max31790_write_pwm() warn: impossible condition '(fan_config < 0) => (0-255 < 0)'
drivers/hwmon/max31790.c:372 max31790_pwm_is_visible() warn: impossible condition '(fan_config < 0) => (0-255 < 0)'

vim +263 drivers/hwmon/max31790.c

54187ff9d766b2 Guenter Roeck   2016-07-01  257  static umode_t max31790_fan_is_visible(const void *_data, u32 attr, int channel)
195a4b4298a795 Il Han          2015-08-30  258  {
54187ff9d766b2 Guenter Roeck   2016-07-01  259  	const struct max31790_data *data = _data;
2c8602cfaeab63 Václav Kubernát 2021-03-16  260  	struct regmap *regmap = data->regmap;
2c8602cfaeab63 Václav Kubernát 2021-03-16  261  	u8 fan_config = read_reg_byte(regmap, MAX31790_REG_FAN_CONFIG(channel % NR_CHANNEL));
2c8602cfaeab63 Václav Kubernát 2021-03-16  262  
2c8602cfaeab63 Václav Kubernát 2021-03-16 @263  	if (fan_config < 0)
                                                            ^^^^^^^^^^^^^^
A u8 can't be negative.

2c8602cfaeab63 Václav Kubernát 2021-03-16  264  		return 0;
54187ff9d766b2 Guenter Roeck   2016-07-01  265  
54187ff9d766b2 Guenter Roeck   2016-07-01  266  	switch (attr) {
54187ff9d766b2 Guenter Roeck   2016-07-01  267  	case hwmon_fan_input:
54187ff9d766b2 Guenter Roeck   2016-07-01  268  	case hwmon_fan_fault:
54187ff9d766b2 Guenter Roeck   2016-07-01  269  		if (channel < NR_CHANNEL ||
54187ff9d766b2 Guenter Roeck   2016-07-01  270  		    (fan_config & MAX31790_FAN_CFG_TACH_INPUT))
dc8dbb4d7672b7 Guenter Roeck   2018-12-10  271  			return 0444;
54187ff9d766b2 Guenter Roeck   2016-07-01  272  		return 0;
54187ff9d766b2 Guenter Roeck   2016-07-01  273  	case hwmon_fan_target:
54187ff9d766b2 Guenter Roeck   2016-07-01  274  		if (channel < NR_CHANNEL &&
54187ff9d766b2 Guenter Roeck   2016-07-01  275  		    !(fan_config & MAX31790_FAN_CFG_TACH_INPUT))
dc8dbb4d7672b7 Guenter Roeck   2018-12-10  276  			return 0644;
54187ff9d766b2 Guenter Roeck   2016-07-01  277  		return 0;
54187ff9d766b2 Guenter Roeck   2016-07-01  278  	default:
54187ff9d766b2 Guenter Roeck   2016-07-01  279  		return 0;
195a4b4298a795 Il Han          2015-08-30  280  	}
195a4b4298a795 Il Han          2015-08-30  281  }
195a4b4298a795 Il Han          2015-08-30  282  
54187ff9d766b2 Guenter Roeck   2016-07-01  283  static int max31790_read_pwm(struct device *dev, u32 attr, int channel,
54187ff9d766b2 Guenter Roeck   2016-07-01  284  			     long *val)
195a4b4298a795 Il Han          2015-08-30  285  {
2c8602cfaeab63 Václav Kubernát 2021-03-16  286  	struct max31790_data *data = dev_get_drvdata(dev);
2c8602cfaeab63 Václav Kubernát 2021-03-16  287  	struct regmap *regmap = data->regmap;
2c8602cfaeab63 Václav Kubernát 2021-03-16  288  	int read;
195a4b4298a795 Il Han          2015-08-30  289  
195a4b4298a795 Il Han          2015-08-30  290  	if (IS_ERR(data))
195a4b4298a795 Il Han          2015-08-30  291  		return PTR_ERR(data);
195a4b4298a795 Il Han          2015-08-30  292  
54187ff9d766b2 Guenter Roeck   2016-07-01  293  	switch (attr) {
54187ff9d766b2 Guenter Roeck   2016-07-01  294  	case hwmon_pwm_input:
2c8602cfaeab63 Václav Kubernát 2021-03-16  295  		read = read_reg_word(regmap, MAX31790_REG_PWMOUT(channel));
2c8602cfaeab63 Václav Kubernát 2021-03-16  296  		if (read < 0)
2c8602cfaeab63 Václav Kubernát 2021-03-16  297  			return read;
2c8602cfaeab63 Václav Kubernát 2021-03-16  298  
2c8602cfaeab63 Václav Kubernát 2021-03-16  299  		*val = read >> 8;
54187ff9d766b2 Guenter Roeck   2016-07-01  300  		return 0;
54187ff9d766b2 Guenter Roeck   2016-07-01  301  	case hwmon_pwm_enable:
2c8602cfaeab63 Václav Kubernát 2021-03-16  302  		read = read_reg_byte(regmap, MAX31790_REG_FAN_CONFIG(channel));
2c8602cfaeab63 Václav Kubernát 2021-03-16  303  		if (read < 0)
2c8602cfaeab63 Václav Kubernát 2021-03-16  304  			return read;
2c8602cfaeab63 Václav Kubernát 2021-03-16  305  
2c8602cfaeab63 Václav Kubernát 2021-03-16  306  		if (read & MAX31790_FAN_CFG_RPM_MODE)
54187ff9d766b2 Guenter Roeck   2016-07-01  307  			*val = 2;
2c8602cfaeab63 Václav Kubernát 2021-03-16  308  		else if (read & MAX31790_FAN_CFG_TACH_INPUT_EN)
54187ff9d766b2 Guenter Roeck   2016-07-01  309  			*val = 1;
195a4b4298a795 Il Han          2015-08-30  310  		else
54187ff9d766b2 Guenter Roeck   2016-07-01  311  			*val = 0;
54187ff9d766b2 Guenter Roeck   2016-07-01  312  		return 0;
54187ff9d766b2 Guenter Roeck   2016-07-01  313  	default:
54187ff9d766b2 Guenter Roeck   2016-07-01  314  		return -EOPNOTSUPP;
54187ff9d766b2 Guenter Roeck   2016-07-01  315  	}
195a4b4298a795 Il Han          2015-08-30  316  }
195a4b4298a795 Il Han          2015-08-30  317  
54187ff9d766b2 Guenter Roeck   2016-07-01  318  static int max31790_write_pwm(struct device *dev, u32 attr, int channel,
54187ff9d766b2 Guenter Roeck   2016-07-01  319  			      long val)
195a4b4298a795 Il Han          2015-08-30  320  {
195a4b4298a795 Il Han          2015-08-30  321  	struct max31790_data *data = dev_get_drvdata(dev);
2c8602cfaeab63 Václav Kubernát 2021-03-16  322  	struct regmap *regmap = data->regmap;
54187ff9d766b2 Guenter Roeck   2016-07-01  323  	u8 fan_config;
54187ff9d766b2 Guenter Roeck   2016-07-01  324  	int err = 0;
195a4b4298a795 Il Han          2015-08-30  325  
54187ff9d766b2 Guenter Roeck   2016-07-01  326  	switch (attr) {
54187ff9d766b2 Guenter Roeck   2016-07-01  327  	case hwmon_pwm_input:
54187ff9d766b2 Guenter Roeck   2016-07-01  328  		if (val < 0 || val > 255) {
54187ff9d766b2 Guenter Roeck   2016-07-01  329  			err = -EINVAL;
54187ff9d766b2 Guenter Roeck   2016-07-01  330  			break;
54187ff9d766b2 Guenter Roeck   2016-07-01  331  		}
2c8602cfaeab63 Václav Kubernát 2021-03-16  332  		err = write_reg_word(regmap, MAX31790_REG_PWMOUT(channel), val << 8);
195a4b4298a795 Il Han          2015-08-30  333  		break;
54187ff9d766b2 Guenter Roeck   2016-07-01  334  	case hwmon_pwm_enable:
2c8602cfaeab63 Václav Kubernát 2021-03-16  335  		fan_config = read_reg_byte(regmap, MAX31790_REG_FAN_CONFIG(channel % NR_CHANNEL));
2c8602cfaeab63 Václav Kubernát 2021-03-16  336  
2c8602cfaeab63 Václav Kubernát 2021-03-16 @337  		if (fan_config < 0)
2c8602cfaeab63 Václav Kubernát 2021-03-16  338  			return fan_config;
2c8602cfaeab63 Václav Kubernát 2021-03-16  339  
54187ff9d766b2 Guenter Roeck   2016-07-01  340  		if (val == 0) {
54187ff9d766b2 Guenter Roeck   2016-07-01  341  			fan_config &= ~(MAX31790_FAN_CFG_TACH_INPUT_EN |
54187ff9d766b2 Guenter Roeck   2016-07-01  342  					MAX31790_FAN_CFG_RPM_MODE);
54187ff9d766b2 Guenter Roeck   2016-07-01  343  		} else if (val == 1) {
54187ff9d766b2 Guenter Roeck   2016-07-01  344  			fan_config = (fan_config |
54187ff9d766b2 Guenter Roeck   2016-07-01  345  				      MAX31790_FAN_CFG_TACH_INPUT_EN) &
54187ff9d766b2 Guenter Roeck   2016-07-01  346  				     ~MAX31790_FAN_CFG_RPM_MODE;
54187ff9d766b2 Guenter Roeck   2016-07-01  347  		} else if (val == 2) {
54187ff9d766b2 Guenter Roeck   2016-07-01  348  			fan_config |= MAX31790_FAN_CFG_TACH_INPUT_EN |
54187ff9d766b2 Guenter Roeck   2016-07-01  349  				      MAX31790_FAN_CFG_RPM_MODE;
54187ff9d766b2 Guenter Roeck   2016-07-01  350  		} else {
54187ff9d766b2 Guenter Roeck   2016-07-01  351  			err = -EINVAL;
195a4b4298a795 Il Han          2015-08-30  352  			break;
54187ff9d766b2 Guenter Roeck   2016-07-01  353  		}
2c8602cfaeab63 Václav Kubernát 2021-03-16  354  		err = regmap_write(regmap,
54187ff9d766b2 Guenter Roeck   2016-07-01  355  				   MAX31790_REG_FAN_CONFIG(channel),
54187ff9d766b2 Guenter Roeck   2016-07-01  356  				   fan_config);
195a4b4298a795 Il Han          2015-08-30  357  		break;
195a4b4298a795 Il Han          2015-08-30  358  	default:
54187ff9d766b2 Guenter Roeck   2016-07-01  359  		err = -EOPNOTSUPP;
54187ff9d766b2 Guenter Roeck   2016-07-01  360  		break;
195a4b4298a795 Il Han          2015-08-30  361  	}
195a4b4298a795 Il Han          2015-08-30  362  
195a4b4298a795 Il Han          2015-08-30  363  	return err;
195a4b4298a795 Il Han          2015-08-30  364  }
195a4b4298a795 Il Han          2015-08-30  365  
54187ff9d766b2 Guenter Roeck   2016-07-01  366  static umode_t max31790_pwm_is_visible(const void *_data, u32 attr, int channel)
195a4b4298a795 Il Han          2015-08-30  367  {
54187ff9d766b2 Guenter Roeck   2016-07-01  368  	const struct max31790_data *data = _data;
2c8602cfaeab63 Václav Kubernát 2021-03-16  369  	struct regmap *regmap = data->regmap;
2c8602cfaeab63 Václav Kubernát 2021-03-16  370  	u8 fan_config = read_reg_byte(regmap, MAX31790_REG_FAN_CONFIG(channel % NR_CHANNEL));
2c8602cfaeab63 Václav Kubernát 2021-03-16  371  
2c8602cfaeab63 Václav Kubernát 2021-03-16 @372  	if (fan_config < 0)
2c8602cfaeab63 Václav Kubernát 2021-03-16  373  		return 0;
54187ff9d766b2 Guenter Roeck   2016-07-01  374  
54187ff9d766b2 Guenter Roeck   2016-07-01  375  	switch (attr) {
54187ff9d766b2 Guenter Roeck   2016-07-01  376  	case hwmon_pwm_input:
54187ff9d766b2 Guenter Roeck   2016-07-01  377  	case hwmon_pwm_enable:
54187ff9d766b2 Guenter Roeck   2016-07-01  378  		if (!(fan_config & MAX31790_FAN_CFG_TACH_INPUT))
dc8dbb4d7672b7 Guenter Roeck   2018-12-10  379  			return 0644;
54187ff9d766b2 Guenter Roeck   2016-07-01  380  		return 0;
54187ff9d766b2 Guenter Roeck   2016-07-01  381  	default:
54187ff9d766b2 Guenter Roeck   2016-07-01  382  		return 0;
54187ff9d766b2 Guenter Roeck   2016-07-01  383  	}
54187ff9d766b2 Guenter Roeck   2016-07-01  384  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--ImRTeRIkqB4CPXi5
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--ImRTeRIkqB4CPXi5--
